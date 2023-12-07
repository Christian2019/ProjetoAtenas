extends Node2D

var id=5
var maxHp=120
var hp = maxHp
var damages = {
	"damage":2.0,
	"arrowDamage":3.5
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 4.0
var currentAnimation="Flying"
var verticalDir="down"
var last_vDir
var horizontalDir="right"
var last_hDir

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var targetMinDistance=150

var cd=3
var onCd=true

var moveBackWardsX=false
var moveBackWardsY=false

var attackSpeedModifierVar=[nextHitDelay,cd]

func _ready():
	maxHp=maxHp*AllSkillsValues.enemyBaseHpWaveMultiplier**(Global.WaveController.wave-1)
	hp = maxHp
	for i in range(0,damages.values().size(),1):
		damages[damages.keys()[i]]*=AllSkillsValues.enemyBaseDamageWaveMultiplier**(Global.WaveController.wave-1)
	if Global.WaveController.wave>10:
		dracmas=2
		
	playAnimation("Flying")
	last_vDir=verticalDir
	last_hDir=horizontalDir
	maxHpBarWidth=$HPBar/Red.size.x
	Global.timerCreator("disableCd",attackSpeedModifierVar[1],[],self)
	getCloserTarget()



func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
		
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]

	move()
	attack()
	hpBarController()

func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)
	

func changeAnimDir():
	var currentFrame=$AnimatedSprite2D.frame
	
	playAnimation(currentAnimation)
	$AnimatedSprite2D.frame=currentFrame+1

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
	arrow.damage=damages.arrowDamage

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
		currentAnimation="Attacking"
		playAnimation(currentAnimation)
				
		onCd=true
		Global.timerCreator("disableCd",attackSpeedModifierVar[1],[],self)
	
	#Dano de contato
	if (!playerInside and !centerPointInside):
		return
		
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
	var targetPointX= target.global_position.x
	var targetPointY= target.global_position.y
	var distanceXtoTarget = global_position.x-targetPointX
	var distanceYtoTarget = global_position.y-targetPointY
	
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
	if currentAnimation=="Attacking":
		currentAnimation="Flying"
		playAnimation("Flying")
		shoot()
