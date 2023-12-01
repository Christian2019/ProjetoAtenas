extends Node2D

var id=7
var maxHp=500
var hp = maxHp
var lastHpCheck=maxHp
var damages = {
	"damage":1.0,
	"projectileDamage":10.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 2.0
var verticalDir="down"
var horizontalDir="right"

var playerInside=false
var centerPointInside=false

var dracmas=1

var playerMinDistance=200

var playerMaxDistance=playerMinDistance*1.5

var playerCircleMove=false

var centerCirclePoint

var rotationAngle=0

var radSpeed

var attackSpeedModifierVar=[nextHitDelay]


func _ready():
	playAnimation()
	maxHpBarWidth=$HPBar/Red.size.x
	speed = float(RandomNumberGenerator.new().randi_range(10*speed/2, 10*speed))/10	
	radSpeed=speed/2

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
		
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]

	move()
	attack()
	hpBarController()
	

func playAnimation ():
	var currentFrame = $AnimatedSprite2D.frame
	$AnimatedSprite2D.play("Flying_"+verticalDir+"_"+horizontalDir)
	$AnimatedSprite2D.frame = currentFrame+1

func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false	

func shoot():
	var ryuseiken = PreLoads.ryuseiken.instantiate()
	ryuseiken.angle= RandomNumberGenerator.new().randi_range(0, 360)
	Global.Game.get_node("Instances/Projectiles").add_child(ryuseiken)
	ryuseiken.global_position=global_position
	ryuseiken.damage=damages.projectileDamage


func attack():
	if (lastHpCheck!=hp):
		lastHpCheck=hp
		shoot()
	
	#Dano de contato
	if (!playerInside and !centerPointInside):
		return
		
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
	
	if (abs(global_position.distance_to(Global.player.global_position))<playerMinDistance and !playerCircleMove):
		playerCircleMove=true
		centerCirclePoint= Vector2(Global.player.global_position.x,Global.player.global_position.y)
		rotationAngle=rad_to_deg(global_position.angle_to_point(centerCirclePoint))
		if (rotationAngle<0):
			rotationAngle= 360+rotationAngle
	elif (abs(global_position.distance_to(Global.player.global_position))>playerMaxDistance and playerCircleMove):
		playerCircleMove=false
	
	if (playerCircleMove):
		var relativePosition=Vector2(playerMinDistance*cos(deg_to_rad(rotationAngle)),playerMinDistance*sin(deg_to_rad(rotationAngle)))
		var movement= centerCirclePoint-relativePosition
		if tryToMove(movement.x-global_position.x,movement.y-global_position.y):
			rotationAngle+=radSpeed
	else:
		var target
		if (Global.player.farming):
			target=Global.Game.get_node("Zones/Center").global_position
		else:
			target=Global.player.global_position
			
		var angle = global_position.angle_to_point(target)
		global_position+=Vector2(speed*cos(angle),speed*sin(angle))
		#tryToMove(speed*cos(angle),speed*sin(angle))
	
	var last_horizontalDir = horizontalDir
	var last_verticalDir = verticalDir
	
	if (global_position.x-(Global.player.global_position.x)>0):
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (global_position.y-(Global.player.global_position.y)>0):
		verticalDir="up"
	else:
		verticalDir="down"
	
	if last_horizontalDir!= horizontalDir or last_verticalDir != verticalDir:
		playAnimation()
		
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
