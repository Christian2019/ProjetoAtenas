extends Node2D

var id=20
var maxHp=10000
var hp = maxHp
var damages = {
	"damage":110.0,
	"poisonDamage":200.0
	}

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed=4.0
var canMove=true
var currentAnimation="Moving"
var verticalDir="down"
var horizontalDir="right"

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

#Poison
var minDistance=200
var onCd=false
var cd=3
var usingPoison=false
var numberOfProjetiles=10
var poisonSpeed=3

var attackSpeedModifierVar=[nextHitDelay,cd]

func _ready():
	maxHp=maxHp*AllSkillsValues.enemyBaseHpWaveMultiplier**(Global.WaveController.wave-1)
	hp = maxHp
	for i in range(0,damages.values().size(),1):
		damages[damages.keys()[i]]*=AllSkillsValues.enemyBaseDamageWaveMultiplier**(Global.WaveController.wave-1)
	if Global.WaveController.wave>10:
		dracmas=2
		
	maxHpBarWidth=$HPBar/Red.size.x
	
func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
	
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]	
	
	hpBarController()	
	getTarget()
	
	attack()
	
	move()

	contactDamage()
	

func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)

func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
		
		
	#Animacao de morte
	call_deferred("queue_free")
	
func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth	
	
func getTarget():
	
	var center = Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D")
	var player = Global.player
	
	if (player.playerOnCenterPoint or player.farming):
		target=center
	else:
		target=player
	
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

func move():
	if (!canMove):
		return
	
	
	if (currentAnimation != "Moving"):
		currentAnimation = "Moving"

	var targetPointX= target.position.x
	var targetPointY= target.position.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = speed*(distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	position.x -= speedXModifier
	position.y -= speedYModifier
	
	playAnimation(currentAnimation)

func attack():
	if (!onCd and global_position.distance_to(target.global_position)<minDistance):
		spit()
		onCd=true
		Global.timerCreator("disableCD",attackSpeedModifierVar[1],[],self)
		canMove=false
		usingPoison=true
		#currentAnimation = "Spiting"
		#playAnimation(currentAnimation)
		#$AnimatedSprite2D.frame=0
		return
	
	if (usingPoison):
		if $AnimatedSprite2D.frame==$AnimatedSprite2D.sprite_frames.get_frame_count("Spiting"+"_"+verticalDir+"_"+horizontalDir)-1:
			usingPoison=false
		return
		
	if (playerInside or (centerPointInside and (Global.player.playerOnCenterPoint or Global.player.farming))):
		canMove=false
		if (currentAnimation != "Attacking"):
			currentAnimation = "Attacking"
		playAnimation(currentAnimation)
	else:
		canMove=true

func spit():
	currentAnimation = "Spiting"
	playAnimation(currentAnimation)
	$AnimatedSprite2D.frame=0
	for i in range(0,360,int(360.0/numberOfProjetiles)):
		var p= PreLoads.poison.instantiate()
		p.speed=poisonSpeed
		p.damage=damages.poisonDamage
		p.worm=self
		p.target = poisonTarget(i)
		Global.Game.get_node("Instances/Projectiles").add_child(p)
		p.global_position=global_position

func poisonTarget(angle):
	var relativePosition= Vector2(0,0)
	relativePosition.y=(minDistance*2)*cos(deg_to_rad(angle))
	relativePosition.x=(minDistance*2)*sin(deg_to_rad(angle))
	return global_position+relativePosition


func disableCD():
	onCd=false	
	
func contactDamage():
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[0],self)
		Global.player.hp-=damages.damage
		Global.player.activateFeedback()
		if (Global.player.hp<0):
			Global.player.hp=0
			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[1],self)
		
		Global.Game.get_node("Zones/Center").hp-=damages.damage
		Global.Game.get_node("Zones/Center").activateFeedback()
		if (Global.Game.get_node("Zones/Center").hp<0):
			Global.Game.get_node("Zones/Center").hp=0
			
func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false

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
