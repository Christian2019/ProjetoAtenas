extends Node2D

var id=16
var maxHp=500
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

var speed = 2

var isMoving=true

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var stage=0

var onCD=false
var totalCd=5
var headCd=0.5

var moveTarget

var heads=4

var checkedHeads=false

func _ready():
	maxHpBarWidth=$HPBar/Red.size.x
	getRandomMoveTarget()
	$Head2.frame=7
	$Head3.frame=3
	$Head4.frame=12

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

	getTarget()
	hpBarController()
	
	move()
	
	headsController()
		
	attackController()
	
	contactDamage()

func headsController():
	if (!checkedHeads):
		checkedHeads=true
		if (heads==2):
			$Head3.visible=false
			$Head4.visible=false
		elif (heads==1):
			$Head3.visible=false
			$Head4.visible=false
			$Head2.visible=false		
	
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
	Global.timerCreator("enableAttack",totalCd,[],self)
	
	if (heads==4):
		createFireBall($Head1.global_position)
		Global.timerCreator("createFireBall",headCd,[$Head2.global_position],self)
		Global.timerCreator("createFireBall",headCd*2,[$Head3.global_position],self)
		Global.timerCreator("createFireBall",headCd*3,[$Head4.global_position],self)
	elif(heads==2):
		createFireBall($Head1.global_position)
		Global.timerCreator("createFireBall",headCd,[$Head2.global_position],self)
	else:
		createFireBall($Head1.global_position)
		
		
		
func createFireBall(headPosition):
		var fireball = PreLoads.fireball.instantiate()
		var angle = headPosition.angle_to_point(target.global_position)
		angle = rad_to_deg(angle)
		fireball.angle= angle
		Global.Game.get_node("Instances/Projectiles").add_child(fireball)
		fireball.global_position=headPosition
		fireball.damage= damages.projectileDamage


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
	if heads!=1:
		spawnChild()

	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
			
			
	#Animacao de morte
	call_deferred("queue_free")

		
func spawnChild():
	var maxI=2
	if (heads==2):
		maxI=1

	for i in range(0,maxI,1):
		var hydra = PreLoads.id016.instantiate()
		hydra.heads=maxI
		hydra.global_position = global_position
		var x = PreLoads.x.instantiate()
		x.global_position=global_position
		Global.Game.get_node("Instances/X").call_deferred("add_child",x)
		Global.timerCreator("spawnEnemy",Global.WaveController.xDuration,[hydra,x],Global.WaveController)
	

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
		$Head1.flip_h=true
		$Head2.flip_h=true
		$Head3.flip_h=true
		$Head4.flip_h=true
	else:
		$Head1.flip_h=false
		$Head2.flip_h=false
		$Head3.flip_h=false
		$Head4.flip_h=false

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
