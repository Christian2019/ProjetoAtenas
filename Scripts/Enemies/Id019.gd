extends Node2D

var id=19
var maxHp=5000
var hp = maxHp
var damages = {
	"damage":4.0,
	"chargeDamage":50.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 3.0
var isMoving=true
var currentAnimation="Walking"
var verticalDir="down"
var horizontalDir="right"

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var charging=false
var loading=false
var canCharge=true
var chargeSpeed = 10
var chargeLoading=1
var chargeCD=5.0
var chargeFrame=0
var chargeMaxFrame=2.5*60
#var minRadiusFromPlayer=chargeSpeed*chargeMaxFrame
var minRadiusFromPlayer=500

var attackSpeedModifierVar=[nextHitDelay,chargeCD]

func _ready():
	playAnimation(currentAnimation)
	maxHpBarWidth=$HPBar/Red.size.x

func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
		
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]	
		
	getCloserTarget()
	checkPlayerDistance()

	if (charging):
		chargeFunction()
		return
	
	if (isMoving):
		move()
	if (playerInside or centerPointInside):
		isMoving=false
		attack()
	else:
		isMoving=true
		
	hpBarController()

func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)
	

func checkPlayerDistance():
	if (global_position.distance_to(Global.player.global_position)<minRadiusFromPlayer and canCharge):
		canCharge=false
		charging=true
		loading=true
		#$AnimatedSprite2D.play("Running")
		Global.timerCreator("disableLoading",chargeLoading,[],self)
	
	if loading:
		playAnimation("Charging")

func disableLoading():
	loading=false
	$AnimatedSprite2D.speed_scale=chargeSpeed/speed
	
	
func chargeFunction():
	if (!loading):
		if (global_position.distance_to(Global.player.global_position)<minRadiusFromPlayer and chargeFrame<chargeMaxFrame):
			chargeFrame+=1
			if (playerInside):
				Global.MathController.damageController(damages.chargeDamage,Global.player)
				Global.player.activateFeedback()
				chargeFrame=chargeMaxFrame
		
			chargeMove()
		else:
			chargeFrame=0
			$AnimatedSprite2D.speed_scale=1
			charging=false
			canCharge=false
			Global.timerCreator("enableCharge",attackSpeedModifierVar[1],[],self)
#	else:
#		var targetPointX= Global.player.position.x
#		var distanceXtotTarget = position.x-targetPointX
#		
#		if (distanceXtotTarget>0):
#			$AnimatedSprite2D.flip_h=true
#		else:
#			$AnimatedSprite2D.flip_h=false

			
func enableCharge():
	canCharge=true

func chargeMove():

	var movement = getSpeedModifier()
	if (!tryToMove(movement.x,movement.y)):
		chargeFrame=chargeMaxFrame
	playAnimation("Dashing")
#	if (movement.z>0):
#		$AnimatedSprite2D.flip_h=true
#	else:
#		$AnimatedSprite2D.flip_h=false

func getSpeedModifier():
	var targetPointX= Global.player.position.x
	var targetPointY= Global.player.position.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = chargeSpeed*(-distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = chargeSpeed*(-distanceYtoTarget/absoluteTotalValue)
	
	return (Vector3(speedXModifier,speedYModifier,distanceXtotTarget))

func tryToMove(speedX,speedY):
	var topSpeed = 150
	if (abs(speedX)>topSpeed):
		speedX=speedX*topSpeed/abs(speedX)
	if (abs(speedY)>topSpeed):
		speedY=speedY*topSpeed/abs(speedY)
		
	var blockedAreas =	[]
	
	for i in range(0,Global.Game.get_node("Zones/BockedAreas").get_child_count(),1):
		blockedAreas.append(Global.Game.get_node("Zones/BockedAreas").get_child(i))
		
	#blockedAreas.append(Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D"))
		
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

func getCloserTarget():
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		target=center
		return
	
	if (global_position.distance_to(player.global_position)<global_position.distance_to(center.global_position)):
		target=player
	else:
		target=center
	
	var distanceXtotTarget = position.x-target.position.x
	var distanceYtoTarget = position.y-target.position.y
	
	if (distanceXtotTarget>0):
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (distanceYtoTarget>0):
		verticalDir="up"
	else:
		verticalDir="down"

func attack():
	if (currentAnimation!= "Attacking"):
		currentAnimation= "Attacking"
	playAnimation(currentAnimation)
		
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[0],self)
		Global.MathController.damageController(damages.damage,Global.player)
		Global.player.activateFeedback()

			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[1],self)
		
		Global.Game.get_node("Zones/Center").hp-=damages.damage
		Global.Game.get_node("Zones/Center").activateFeedback()

	

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
	if (currentAnimation!= "Walking"):
		currentAnimation= "Walking"
	playAnimation(currentAnimation)

	var targetPointX= target.position.x
	var targetPointY= target.position.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = speed*(distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	position.x -= speedXModifier
	position.y -= speedYModifier
	
#	if (distanceXtotTarget>0):
#		$AnimatedSprite2D.flip_h=true
#	else:
#		$AnimatedSprite2D.flip_h=false


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
