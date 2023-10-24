extends Node2D

var id=15
var maxHp=30000
var hp = maxHp
var damages = {
	"damage":1.0,
	"projectileDamage":50.0
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

var target

var dracmas=10

var stage=0

var cd0 = 1.25
var cd1 = 1
var cd2 = 0.75

var onCD=false

var wave

var moveTarget

func _ready():
	maxHpBarWidth=$HPBar/Red.size.x
	wave = Global.WaveController.get_child(Global.WaveController.wave-1)
	getRandomMoveTarget()

func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false
		
func enableAttack():
	onCD=false

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
	
	
	stageController()
	
		
	getTarget()
	hpBarController()
	
	move()
		
	attackController()
	
	contactDamage()

func stageController():
	
	if ((wave.battleFrame>25*60) and stage==0):
		stage=1
		$AudioStreamPlayer.play(0)

	elif ((wave.battleFrame>50*60) and stage==1):
		stage=2
		$AudioStreamPlayer.play(0)



		
func getTarget():
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		target=center
	else:
		target=player
	
func attackController():
	if (onCD):
		return
	onCD=true
	if (stage==0):
		Global.timerCreator("enableAttack",cd0,[],self)
		stage0Func(PreLoads.id008.instantiate())
	elif(stage==1):
		Global.timerCreator("enableAttack",cd1,[],self)
		stage1Func()
	else:
		Global.timerCreator("enableAttack",cd2,[],self)
		stage1Func()
		var rng =RandomNumberGenerator.new().randi_range(0, 2)
		if (rng==0):
			stage0Func(PreLoads.id008.instantiate())
		elif (rng==1):
			stage0Func(PreLoads.id003.instantiate())
		elif (rng==2):
			stage0Func(PreLoads.id014.instantiate())
		
		
		
func stage0Func(enemy):
		enemy.global_position = global_position
		var x = PreLoads.x.instantiate()
		x.global_position=global_position
		x.useSpriteBlue()
		Global.Game.get_node("Instances/X").call_deferred("add_child",x)
		Global.timerCreator("spawnEnemy",Global.WaveController.xDuration,[enemy,x],Global.WaveController)
		
	
func stage1Func():
		for i in range(-30,31,15):
			if (i==0):
				continue
			var energyBall = PreLoads.energyBall.instantiate()
			energyBall.angle= rad_to_deg(global_position.angle_to_point(target.global_position))+i
			Global.Game.get_node("Instances/Projectiles").add_child(energyBall)
			energyBall.global_position=global_position
			energyBall.damage=damages.projectileDamage
		
func contactDamage():
	##Colisao por contado
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",nextHitDelay,[0],self)
		Global.player.hp-=damages.damage
		Global.player.activateFeedback()
		if (Global.player.hp<0):
			Global.player.hp=0
			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",nextHitDelay,[1],self)
		
		Global.Game.get_node("Zones/Center").hp-=damages.damage
		Global.Game.get_node("Zones/Center").activateFeedback()
		if (Global.Game.get_node("Zones/Center").hp<0):
			Global.Game.get_node("Zones/Center").hp=0
	

func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth
	


func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
		
		
	#Animacao de morte
	call_deferred("queue_free")

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

func getRandomMoveTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	moveTarget = Vector2(x,y) 


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
