extends Node2D

var id=4
var maxHp=300
var hp = maxHp
var damages = {
	"damage":1.0,
	"chargeDamage":10.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 1
var isMoving=true

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var charging=false
var loading=false
var canCharge=true
var chargeSpeed = 10
var chargeLoading=2
var chargeCD=5
var chargeFrame=0
var chargeMaxFrame=2.5*60
#var minRadiusFromPlayer=chargeSpeed*chargeMaxFrame
var minRadiusFromPlayer=500



func _ready():
	$AnimatedSprite2D.play("Walking")
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
	
func checkPlayerDistance():
	if (global_position.distance_to(Global.player.global_position)<minRadiusFromPlayer and canCharge):
		canCharge=false
		charging=true
		loading=true
		$AnimatedSprite2D.play("Charging")
		Global.timerCreator("disableLoading",chargeLoading,[],self)

func disableLoading():
	loading=false
	$AnimatedSprite2D.play("Walking")
	$AnimatedSprite2D.speed_scale=chargeSpeed/speed
	
	
func chargeFunction():
	if (!loading):
		if (global_position.distance_to(Global.player.global_position)<minRadiusFromPlayer and chargeFrame<chargeMaxFrame):
			chargeFrame+=1
			if (playerInside):
				Global.player.hp-=damages.chargeDamage
				Global.player.activateFeedback()
				chargeFrame=chargeMaxFrame
				if (Global.player.hp<0):
					Global.player.hp=0
			chargeMove()
		else:
			chargeFrame=0
			$AnimatedSprite2D.speed_scale=1
			charging=false
			canCharge=false
			Global.timerCreator("enableCharge",chargeCD,[],self)
	else:
		var targetPointX= Global.player.position.x
		var distanceXtotTarget = position.x-targetPointX
		
		if (distanceXtotTarget>0):
			$AnimatedSprite2D.flip_h=true
		else:
			$AnimatedSprite2D.flip_h=false

			
func enableCharge():
	canCharge=true

func chargeMove():

	var movement = getSpeedModifier()
	if (!tryToMove(movement.x,movement.y)):
		chargeFrame=chargeMaxFrame

	if (movement.z>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false

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

func attack():
	if ($AnimatedSprite2D.animation!= "Attacking"):
		$AnimatedSprite2D.animation= "Attacking"
		
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
	if ($AnimatedSprite2D.animation!= "Walking"):
		$AnimatedSprite2D.animation= "Walking"

	var targetPointX= target.position.x
	var targetPointY= target.position.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = speed*(distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	position.x -= speedXModifier
	position.y -= speedYModifier
	
	if (distanceXtotTarget>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false


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
