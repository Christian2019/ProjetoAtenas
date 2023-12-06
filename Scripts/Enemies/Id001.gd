extends Node2D

var id=1
var maxHp=30
var hp = maxHp
var damages = {
	"damage":1.0
	}


var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1.0

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 1.0
var isMoving=true
var currentAnimation="Walking"
var verticalDir="down"
var horizontalDir="right"

var playerInside=false
var centerPointInside=false

var target

var dracmas=1

var attackSpeedModifierVar=[nextHitDelay]

func _ready():
	playAnimation(currentAnimation)
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
	
	$AnimatedSprite2D.speed_scale=nextHitDelay/attackSpeedModifierVar[0]	
	
	getCloserTarget()
	
	if (isMoving):
		move()
	if (playerInside or centerPointInside):
		isMoving=false
		attack()
	else:
		isMoving=true
		
	hpBarController()
	
func playAnimation (animName):
	$AnimatedSprite2D.play(animName+"_"+verticalDir+"_"+horizontalDir)
	
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
	if (currentAnimation!= "Attacking"):
		currentAnimation= "Attacking"
	playAnimation(currentAnimation)
		
	if (playerInside and !nextHitDelayPlayer):
		nextHitDelayPlayer=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[0],self)
		Global.MathController.damageController(damages.damage,Global.player)
		
		Global.player.activateFeedback()
		if (Global.player.hp<0):
			Global.player.hp=0
			
	if (centerPointInside and !nextHitDelayCenterPoint):
		nextHitDelayCenterPoint=true
		Global.timerCreator("enableHit",attackSpeedModifierVar[0],[1],self)
		Global.MathController.damageController(damages.damage,Global.Game.get_node("Zones/Center"))
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
	if (currentAnimation!= "Walking"):
		currentAnimation= "Walking"
	
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
		horizontalDir="left"
	else:
		horizontalDir="right"
	
	if (distanceYtoTarget>0):
		verticalDir="up"
	else:
		verticalDir="down"
	
	playAnimation(currentAnimation)


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
