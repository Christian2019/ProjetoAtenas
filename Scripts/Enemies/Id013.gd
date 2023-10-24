extends Node2D

var id=13
var maxHp=20000
var hp = maxHp
var damages = {
	"damage":1.0,
	"arrowDamage":50.0
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

var targetAttackMinDistance=500

var cd0 = 1.25
var cd1 = 1
var cd2 = 0.75

var onCD=false

var moveBackWardsX=false
var moveBackWardsY=false

var wave

var moveTargetStage2

func _ready():
	maxHpBarWidth=$HPBar/Red.size.x
	wave = Global.WaveController.get_child(Global.WaveController.wave-1)

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
	
	if (global_position.distance_to(target.global_position)>speed):
		move()
	
	attack()

func stageController():
	if ((float(hp)<0.75*float(maxHp) or wave.battleFrame>33*60) and stage==0):
		stage=1
		$AudioStreamPlayer.play(0)
	elif ((float(hp)<0.40*float(maxHp) or wave.battleFrame>66*60) and stage==1):
		stage=2
		targetAttackMinDistance=250
		$AudioStreamPlayer.play(0)
		getRandomMoveTarget()


		
func getTarget():
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		target=center
	else:
		target=player
	

func attack():
	
	createArrowAttack()
	
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
	
func createArrowAttack():
	if (onCD):
		return
	
	if (stage==0):
		if (global_position.distance_to(target.global_position)<targetAttackMinDistance):
			onCD=true
			Global.timerCreator("enableAttack",cd0,[],self)
			var angle = rad_to_deg(global_position.angle_to_point(target.global_position))
			spawnArrow(Vector2(20,10),angle)
			spawnArrow(Vector2(-20,-40),angle)
			spawnArrow(Vector2(-40,20),angle)
			spawnArrow(Vector2(-20,40),angle)
			
	elif (stage==1):
		if (global_position.distance_to(target.global_position)<targetAttackMinDistance):
			onCD=true
			Global.timerCreator("enableAttack",cd1,[],self)
			var rng = RandomNumberGenerator.new()
			for i in range(0,8,1):
				var angle = RandomNumberGenerator.new().randi_range(0, 360)
				var radios = 300
				var x = rng.randi_range(0, radios*2)-radios
				var y = rng.randi_range(0, radios*2)-radios
				spawnArrow(Vector2(x,y),angle)
	
	else:
		onCD=true
		Global.timerCreator("enableAttack",cd2,[],self)
		var rng = RandomNumberGenerator.new()
		for i in range(0,8,1):
			var angle = RandomNumberGenerator.new().randi_range(0, 360)
			var radios = 300
			var x = rng.randi_range(0, radios*2)-radios
			var y = rng.randi_range(0, radios*2)-radios
			spawnArrow(Vector2(x,y),angle)

func spawnArrow(rel_position,angle):
	rel_position.x=rel_position.x*sin(deg_to_rad(angle))
	rel_position.y=rel_position.y*cos(deg_to_rad(angle))
	var arrow_position= target.global_position+rel_position
	var arrowAttack = PreLoads.arrowAttackId013.instantiate()
	arrowAttack.rotation_degrees= angle
	Global.Game.get_node("Instances/Projectiles").add_child(arrowAttack)
	arrowAttack.global_position=arrow_position
	arrowAttack.damage= damages.arrowDamage
		

func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
		
		
	#Animacao de morte
	call_deferred("queue_free")

func move():
	
	var tagetMovement
	if stage==2:
		if (global_position.distance_to(moveTargetStage2))<speed:
			getRandomMoveTarget()
		tagetMovement=moveTargetStage2
	else:
		tagetMovement= target.position
	
	var targetPointX= tagetMovement.x
	var targetPointY= tagetMovement.y
	var distanceXtoTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtoTarget)
	
	var speedXModifier = speed*(distanceXtoTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	if !tryToMove(-speedXModifier,-speedYModifier):
		if stage==2:
			getRandomMoveTarget()
		else:
			target=Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
			
		
	if (distanceXtoTarget>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false

func getRandomMoveTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	moveTargetStage2 = Vector2(x,y) 


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
