extends "res://Scripts/Enemy.gd"

var maxHp=30
var hp = maxHp
var damage = 10

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var speed = 1
var isMoving=true

var playerInside=false
var centerPointInside=false



func _ready():
	super._ready()
	$AnimatedSprite2D.play("Walking")
	maxHpBarWidth=$HPBar/Red.size.x

func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false

func _process(_delta):
	super._process(_delta)
	if (hp<=0):
		hp=0
		die()
		return
	
	if (isMoving):
		move()
	if (playerInside or centerPointInside):
		isMoving=false
		attack()
	else:
		isMoving=true
		
	hpBarController()

func attack():
	if ($AnimatedSprite2D.animation!= "Attacking"):
		$AnimatedSprite2D.animation= "Attacking"
		
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
		
		Global.Game.get_node("Center").hp-=damage
		Global.Game.get_node("Center").activateFeedback()
		if (Global.Game.get_node("Center").hp<0):
			Global.Game.get_node("Center").hp=0
	

func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth

func die():
	#Animacao de morte
	call_deferred("queue_free")

func move():
	if ($AnimatedSprite2D.animation!= "Walking"):
		$AnimatedSprite2D.animation= "Walking"

	var centerPointX= centerPoint.position.x
	var centerPointY= centerPoint.position.y
	var distanceXtoCenter = position.x-centerPointX
	var distanceYtoCenter = position.y-centerPointY
	
	var absoluteTotalValue = abs(distanceYtoCenter)+abs(distanceXtoCenter)
	
	var speedXModifier = speed*(distanceXtoCenter/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoCenter/absoluteTotalValue)

	position.x -= speedXModifier
	position.y -= speedYModifier
	
	if (distanceXtoCenter>0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false


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
