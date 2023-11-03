extends Node2D

var id=2
var maxHp=100
var hp = maxHp
var damages = {
	"damage":1.0
	}

var nextHitDelayPlayer=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 5
var isMoving=true

var playerInside=false

var target

var dracmas=8

func _ready():
	$AnimatedSprite2D.play("Walking")
	maxHpBarWidth=$HPBar/Red.size.x
	getTarget()

func enableHit():
	nextHitDelayPlayer=false


func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
	hpBarController()
	move()
	
	if (playerInside):
		contactDamage()
		
	
func getTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	target = Vector2(x,y) 
	
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
		

func contactDamage():
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",nextHitDelay,[],self)
		Global.MathController.damageController(damages.damage,Global.player)
		Global.player.activateFeedback()
		if (Global.player.hp<0):
			Global.player.hp=0
	

func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth

func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
	
	var item = PreLoads.item.instantiate()
	item.global_position=global_position
	Global.Game.get_node("Instances/Itens").add_child(item)

	#Animacao de morte
	call_deferred("queue_free")

func move():
	if (position.distance_to(target))<speed:
		getTarget()
		
	var movement = getSpeedModifier()
	if (!tryToMove(movement.x,movement.y)):
		getTarget()


	if (movement.z<0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false

func getSpeedModifier():
	var targetPointX= target.x
	var targetPointY= target.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = speed*(-distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = speed*(-distanceYtoTarget/absoluteTotalValue)
	
	return (Vector3(speedXModifier,speedYModifier,distanceXtotTarget))

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		playerInside=true


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerInside=false

