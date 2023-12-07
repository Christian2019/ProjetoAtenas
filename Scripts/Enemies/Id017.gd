extends Node2D

var id=17
var maxHp=7000
var hp = maxHp
var damages = {
	"damage":90.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 4.0
var currentAnimation="move"
var verticalDir="down"
var last_vDir
var horizontalDir="right"
var last_hDir

var isMoving=true

var playerInside=false
var centerPointInside=false

var dracmas=1

var moveTarget

var auraRadios=500.0

var minDistancePlayer=100

var buffedMinions=[]

var hpBuff=2.5
var speedBuff=1.5
var damageBuff=1.25

var attackSpeedModifierVar=[nextHitDelay]

func _ready():
	maxHp=maxHp*AllSkillsValues.enemyBaseHpWaveMultiplier**(Global.WaveController.wave-1)
	hp = maxHp
	for i in range(0,damages.values().size(),1):
		damages[damages.keys()[i]]*=AllSkillsValues.enemyBaseDamageWaveMultiplier**(Global.WaveController.wave-1)
	if Global.WaveController.wave>10:
		dracmas=2
		
	maxHpBarWidth=$HPBar/Red.size.x
	getRandomMoveTarget()
	$Sprite2D.modulate.a=0.1
	$Sprite2D.scale*=int(auraRadios/41)	

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

	hpBarController()
	
	move()
	
	buff()
	
	contactDamage()
	
func buff():
	var enemies = Global.Game.get_node("Enemies")
	for i in range(0,enemies.get_child_count(),1):
		var enemy = enemies.get_child(i)
		
		if (buffedMinions.has(enemy)):
			if (global_position.distance_to(enemy.global_position)>auraRadios):
				buffedMinions.erase(enemy)
				enemy.hp/=hpBuff
				enemy.maxHp/=hpBuff
				enemy.speed/=speedBuff
				for j in range(0,enemy.damages.values().size(),1):
					enemy.damages[str(enemy.damages.keys()[j])] = enemy.damages.values()[j]/damageBuff
		else:
			if (global_position.distance_to(enemy.global_position)<auraRadios):
				buffedMinions.append(enemy)
				enemy.hp*=hpBuff
				enemy.maxHp*=hpBuff
				enemy.speed*=speedBuff
				
				for j in range(0,enemy.damages.values().size(),1):
					enemy.damages[str(enemy.damages.keys()[j])] = enemy.damages.values()[j]*damageBuff


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
		
func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)

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

func closerToPlayer(xS,yS):
	var d1 = global_position.distance_to(Global.player.global_position)
	
	if d1>minDistancePlayer:
		return false
	
	var d2 = (global_position+Vector2(xS,yS)).distance_to(Global.player.global_position)
	
	if (d2<d1):
		return true
	
	return false

func move():

	if (global_position.distance_to(moveTarget))<speed:
			getRandomMoveTarget()

	var targetPointX= moveTarget.x
	var targetPointY= moveTarget.y
	var distanceXtoTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	if (distanceXtoTarget>0):
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (distanceYtoTarget>0):
		verticalDir="up"
	else:
		verticalDir="down"
	
	if last_hDir != horizontalDir or last_vDir != verticalDir:
		last_hDir = horizontalDir
		last_vDir = verticalDir
		changeAnimDir()
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtoTarget)
	
	var speedXModifier = speed*(distanceXtoTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	if !tryToMove(-speedXModifier,-speedYModifier) or closerToPlayer(-speedXModifier,-speedYModifier):
			getRandomMoveTarget()
	
	playAnimation(currentAnimation)

func getRandomMoveTarget():
	var x = RandomNumberGenerator.new().randi_range(0, 2561)
	var y = RandomNumberGenerator.new().randi_range(0, 1280)
	moveTarget = Vector2(x,y) 
	
func changeAnimDir():
	var currentFrame=$AnimatedSprite2D.frame
	
	playAnimation(currentAnimation)
	$AnimatedSprite2D.frame=currentFrame+1

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

