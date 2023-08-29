extends "res://Scripts/Enemy.gd"

var speed = 1
var isMoving=true

var playerInside=false
var centerPointInside=false

func _ready():
	super._ready()
	$AnimatedSprite2D.play("Walking")

func _process(delta):
	super._process(delta)
	if (isMoving):
		move()
	if (playerInside or centerPointInside):
		isMoving=false
		if ($AnimatedSprite2D.animation!= "Attacking"):
			$AnimatedSprite2D.animation= "Attacking"
		if Input.is_action_pressed("Attack1"):
			call_deferred("free")
	
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
