extends Node2D

var id=5
var maxHp=300
var hp = maxHp
var damage = 1

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 4

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var targetMinDistance=150

var cd=3
var onCd=true

var moveBackWardsX=false
var moveBackWardsY=false



func _ready():
	$AnimatedSprite2D.play("Flying")
	maxHpBarWidth=$HPBar/Red.size.x
	Global.timerCreator("disableCd",cd,[],self)
	getCloserTarget()



func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return

	move()
	attack()
	hpBarController()
	
func disableCd():
	onCd=false

func disableMoveBackWardsX():
	moveBackWardsX=false

func disableMoveBackWardsY():
	moveBackWardsY=false
	
func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false	

func shoot():
	var arrow = PreLoads.arrowCircle.instantiate()
	var angleToTarget = rad_to_deg(global_position.angle_to_point(target.global_position))
	arrow.angle=angleToTarget
	Global.Game.get_node("Instances/Projectiles").add_child(arrow)
	arrow.global_position=global_position

func getCloserTarget():
	Global.timerCreator("getCloserTarget",1,[],self)
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
	#Flecha
	if (!onCd):
		$AnimatedSprite2D.play("Attacking")
		onCd=true
		Global.timerCreator("disableCd",cd,[],self)
	
	#Dano de contato
	if (!playerInside and !centerPointInside):
		return
		
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",nextHitDelay,[0],self)
		Global.player.hp-=damage
		Global.player.activateFeedback()
		if (Global.player.hp<0):
			Global.player.hp=0
			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",nextHitDelay,[1],self)
		
		Global.Game.get_node("Zones/Center").hp-=damage
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
	var targetPointX= target.position.x
	var targetPointY= target.position.y
	var distanceXtoTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtoTarget)
	
	var speedXModifier = speed*(distanceXtoTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)
	
	if (abs((position.x-Global.player.position.x))<targetMinDistance):
		if (!moveBackWardsX):
			moveBackWardsX=true
			Global.timerCreator("disableMoveBackWardsX",2,[],self)
			
		
	if (abs((position.y-Global.player.position.y))<targetMinDistance):
		if (!moveBackWardsY):
			moveBackWardsY=true
			Global.timerCreator("disableMoveBackWardsY",2,[],self)
	
	if moveBackWardsX:
		speedXModifier*=-1
		distanceXtoTarget*=-1
	
	if moveBackWardsX:
		speedYModifier*=-1
		
	tryToMove(-speedXModifier,-speedYModifier)
	
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


func _on_animated_sprite_2d_animation_looped():
	if $AnimatedSprite2D.animation=="Attacking":
		$AnimatedSprite2D.play("Flying")
		shoot()
