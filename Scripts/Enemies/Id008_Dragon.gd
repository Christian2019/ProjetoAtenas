extends Node2D

var id=8
var maxHp=1000
var hp = maxHp

var damage = 1

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 2.0

var playerInside=false
var centerPointInside=false

var dracmas=1

var target
var targetMinDistance=200
var targetMaxDistance=targetMinDistance*1.5

var canShoot=true
var shootCD=0.5



func _ready():
	$AnimatedSprite2D.play("Flying")
	maxHpBarWidth=$HPBar/Red.size.x

func enableShoot():
	canShoot=true

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
	
	hpBarController()
	getCloserTarget()
	action()
	if ($AnimatedSprite2D.animation=="Flying"):
		move()
	else:
		attack()
	
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

func action():
	if ($AnimatedSprite2D.animation=="Flying"):
		if (global_position.distance_to(target.global_position)<targetMinDistance):
			$AnimatedSprite2D.animation="Attacking"
	if ($AnimatedSprite2D.animation=="Attacking"):
		if (global_position.distance_to(target.global_position)>targetMaxDistance):
			$AnimatedSprite2D.animation="Flying"
	
	if (global_position.x-(target.global_position.x)>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false
	
func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false	

func shoot():
	var arrowAttack = PreLoads.arrowAttack.instantiate()
	arrowAttack.rotation_degrees= RandomNumberGenerator.new().randi_range(0, 360)
	Global.Game.get_node("Instances/Projectiles").add_child(arrowAttack)
	arrowAttack.global_position=target.global_position


func attack():
	if (canShoot):
		canShoot=false
		Global.timerCreator("enableShoot",shootCD,[],self)
		shoot()
	
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
	var angle = global_position.angle_to_point(target.global_position)
	global_position+=Vector2(speed*cos(angle),speed*sin(angle))
	tryToMove(speed*cos(angle),speed*sin(angle))
	
	



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
