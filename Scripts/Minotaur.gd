extends "res://Scripts/Enemy.gd"

var speed = 1

func _ready():
	super._ready()
	$AnimatedSprite2D.play("Walking")
	if (direction=="W"):
		speed*=-1
		$AnimatedSprite2D.flip_h=true

	
func _process(delta):
	super._process(delta)
	move(speed)

