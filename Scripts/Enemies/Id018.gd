extends Node2D

var id=18
var maxHp=30000
var hp = maxHp
var damages = {
	"damage":1.0,
	"projectileDamage":10.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 5

var isMoving=true

var playerInside=false
var centerPointInside=false

var dracmas=10

var stage=0


var cd=2

var onCD=false

var wave

var moveTarget

##Attacks
#Type0 - Ataque Giratorio ao redor do passaro
var t0Speed=1
var t0QuantityOfGroups=10
var t0SizeGroup=3
var t0GroupDistancing=30
var t0GapDistance=300
var t0StartDistanceFromBoss=100

#Type1 - Ataques proximos ao player
var t1Speed=20
var t1Delay=0.5
var t1radios=500
var t1NumberOfTarget=20

#Type2 - Ataque prisao do player 
var t2DegGap=10
var t2StartDistanceFromPlayer=500

func _ready():
	maxHpBarWidth=$HPBar/Red.size.x
	wave = Global.WaveController.get_child(Global.WaveController.wave-1)
	getRandomMoveTarget()
	createRotationFireEnergy()

func getRandomMoveTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	moveTarget = Vector2(x,y) 
	
func createRotationFireEnergy():
	for i in range(0,t0QuantityOfGroups,1):
		for j in range(0,t0SizeGroup,1):
			var fe= PreLoads.fireEnergy.instantiate()
			fe.type=0
			fe.damage=damages.projectileDamage
			fe.speed=t0Speed
			fe.angle=0
			fe.boss=self
			fe.startDistanceFromBoss=t0StartDistanceFromBoss+(j*t0GroupDistancing)+(i*t0GapDistance)
			Global.Game.get_node("Instances/Projectiles").add_child(fe)
			fe.global_position=global_position+Vector2(fe.startDistanceFromBoss,0)
		

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return

	stageController()

	hpBarController()
	
	move()
		
	attackController()
	
	contactDamage()

func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)

	#Animacao de morte
	call_deferred("queue_free")

func stageController():
	if ((float(hp)<0.75*float(maxHp) or wave.battleFrame>33*60) and stage==0):
		stage=1
		t0Speed=2
		onCD=false
		$AudioStreamPlayer.play(0)
	elif ((float(hp)<0.40*float(maxHp) or wave.battleFrame>66*60) and stage==1):
		stage=2
		t0Speed=3
		$AudioStreamPlayer.play(0)


func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth


func move():

	if (global_position.distance_to(moveTarget))<speed:
			getRandomMoveTarget()

	var targetPointX= moveTarget.x
	var targetPointY= moveTarget.y
	var distanceXtoTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtoTarget)
	
	var speedXModifier = speed*(distanceXtoTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	if !tryToMove(-speedXModifier,-speedYModifier):
			getRandomMoveTarget()
			
		
	if (distanceXtoTarget>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false


func tryToMove(speedX,speedY):
	var topSpeed = 150
	if (abs(speedX)>topSpeed):
		speedX=speedX*topSpeed/abs(speedX)
	if (abs(speedY)>topSpeed):
		speedY=speedY*topSpeed/abs(speedY)
		
	var blockedAreas =	[]
	
	for i in range(0,Global.Game.get_node("Zones/BockedAreas").get_child_count(),1):
		blockedAreas.append(Global.Game.get_node("Zones/BockedAreas").get_child(i))
		
	blockedAreas.append(Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D"))
		
	var nextTryPosition = Vector2(position.x+speedX,position.y+speedY)
	if (!Global.areaBoxCollision(self,nextTryPosition,$Area2D,blockedAreas)):
		position.y+=speedY
		position.x+=speedX
		return true
	else:
		#Faz o movimento limitando a velocidade para que encaixe perfeitamente
		
		var testSpeedStep=0.01
		var testSpeedValue=testSpeedStep
		nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		while (!Global.areaBoxCollision(self,nextTryPosition,$Area2D,blockedAreas)):
			testSpeedValue+=testSpeedStep
			nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		testSpeedValue-=testSpeedStep
		position.y+=speedY*testSpeedValue
		position.x+=speedX*testSpeedValue
		return false
	
func attackController():
	if (onCD):
		return
	onCD=true
	if(stage==1):
		Global.timerCreator("enableAttack",cd,[],self)
		stage1Func()
	elif(stage==2):
		Global.timerCreator("enableAttack",cd,[],self)
		var rng =RandomNumberGenerator.new().randi_range(0, 1)
		if (rng==0):
			stage1Func()
		else:
			stage2Func()
	

	
func enableAttack():
	onCD=false

func stage1Func():
	for i in range(0,t1NumberOfTarget,1):
		var fe= PreLoads.fireEnergy.instantiate()
		fe.type=1
		fe.speed=t1Speed
		fe.damage=damages.projectileDamage
		fe.boss=self
		fe.target = getTarget().global_position+randomVariation()
		fe.delay=t1Delay
		Global.Game.get_node("Instances/Projectiles").add_child(fe)


		
func getTarget():
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		return center

	return player


func randomVariation():
	var v = Vector2(0,0)
	var rng =RandomNumberGenerator.new()
	v.x=rng.randi_range(0, t1radios*2)-t1radios
	v.y=rng.randi_range(0, t1radios*2)-t1radios
	return v
	
func stage2Func():
	for i in range(0,360,t2DegGap):
		var fe= PreLoads.fireEnergy.instantiate()
		fe.type=1
		fe.speed=t1Speed
		fe.damage=damages.projectileDamage
		fe.boss=self
		fe.target = state2Target(i)
		fe.delay=t1Delay
		Global.Game.get_node("Instances/Projectiles").add_child(fe)

func state2Target(angle):
	var target = getTarget().global_position
	var relativePosition= Vector2(0,0)
	relativePosition.y=t2StartDistanceFromPlayer*cos(deg_to_rad(angle))
	relativePosition.x=t2StartDistanceFromPlayer*sin(deg_to_rad(angle))
	return target+relativePosition

func contactDamage():
	##Colisao por contado
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",nextHitDelay,[0],self)
		Global.MathController.damageController(damages.damage,Global.player)
		Global.player.activateFeedback()

			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",nextHitDelay,[1],self)
		
		Global.Game.get_node("Zones/Center").hp-=damages.damage
		Global.Game.get_node("Zones/Center").activateFeedback()


func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false	

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Center"):
		centerPointInside=true
	if (area.get_parent().name=="Player"):
		playerInside=true


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerInside=false
	if (area.get_parent().name=="Center"):
		centerPointInside=false
