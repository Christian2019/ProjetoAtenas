extends Node2D

var id=14
var maxHp=5000
var hp = maxHp
var damages = {
	"damage":70.0,
	"arrowDamage":70.0
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

var targetMaxDistance=200
var targetMinDistance=100

var escapePoint

var cd = 1.0

var onCD=false

var attackSpeedModifierVar=[nextHitDelay,cd]

func _ready():
	maxHp=maxHp*AllSkillsValues.enemyBaseHpWaveMultiplier**(Global.WaveController.wave-1)
	hp = maxHp
	for i in range(0,damages.values().size(),1):
		damages[damages.keys()[i]]*=AllSkillsValues.enemyBaseDamageWaveMultiplier**(Global.WaveController.wave-1)
	if Global.WaveController.wave>10:
		dracmas=2
		
	maxHpBarWidth=$HPBar/Red.size.x
	escapePoint=getRandomMoveTarget()

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
		
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]
	
	getTarget()
	hpBarController()
	
	if (global_position.distance_to(target.global_position)<targetMinDistance or
	global_position.distance_to(target.global_position)>targetMaxDistance):
		move()
	else:
		createArrowAttack()
	
	contactDamage()
	

func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)

func getTarget():
	
	if (global_position.distance_to(escapePoint)<speed):
		escapePoint=getRandomMoveTarget()
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		target=center
	else:
		target=player
	

func contactDamage():

	##Colisao por contado
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
	
func createArrowAttack():
	if (currentAnimation!="Attacking"):
		currentAnimation = "Attacking"
	
	var distanceXtotTarget = global_position.x-target.global_position.x
	var distanceYtoTarget = global_position.y-target.global_position.y
	
	if (distanceXtotTarget>0):
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (distanceYtoTarget>0):
		verticalDir="up"
	else:
		verticalDir="down"
	
	playAnimation(currentAnimation)
	
	if (onCD):
		return
		
		
	onCD=true
	Global.timerCreator("enableAttack",attackSpeedModifierVar[1],[],self)
	var angle = rad_to_deg(global_position.angle_to_point(target.global_position))
	var valueDistance=-70
	var openAngle=70
	spawnArrow(Vector2(valueDistance,valueDistance),angle,(openAngle*(-1)/2))
	spawnArrow(Vector2(valueDistance,valueDistance),angle,(openAngle/2))



func spawnArrow(rel_position,angle,extraAngle):
	rel_position.x=rel_position.x*cos(deg_to_rad(angle))
	rel_position.y=rel_position.y*sin(deg_to_rad(angle))
	var arrow_position= target.global_position+rel_position
	var arrowAttack = PreLoads.arrowAttackId014.instantiate()
	arrowAttack.rotation_degrees= (angle+extraAngle)
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
		
	if (global_position.distance_to(target.global_position)>targetMaxDistance):
		tagetMovement=target.position
	
	elif (global_position.distance_to(target.global_position)<targetMinDistance):
		tagetMovement=escapePoint
	
	
	var speedModifer=getSpeedModifier(tagetMovement)

	if !tryToMove(-speedModifer.x,-speedModifer.y):
		if tagetMovement==escapePoint:
			escapePoint=getRandomMoveTarget()
		else:
			target=Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
			createArrowAttack()
			return

	if (currentAnimation!="Walking"):
		currentAnimation = "Walking"

	var distanceXtotTarget = global_position.x-target.global_position.x
	var distanceYtoTarget = global_position.y-target.global_position.y
	
	if (distanceXtotTarget>0):
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (distanceYtoTarget>0):
		verticalDir="up"
	else:
		verticalDir="down"
	
	playAnimation(currentAnimation)
	


func getSpeedModifier(tagetMovement):
	var targetPointX= tagetMovement.x
	var targetPointY= tagetMovement.y
	var distanceXtoTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtoTarget)
	
	var speedXModifier = speed*(distanceXtoTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)
	
	return Vector3(speedXModifier,speedYModifier,distanceXtoTarget)

func getRandomMoveTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	return Vector2(x,y) 


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
