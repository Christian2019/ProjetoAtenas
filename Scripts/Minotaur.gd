extends "res://Scripts/Enemy.gd"

var speed = 1
var isMoving=true

var playerInside=false

func _ready():
	super._ready()
	$AnimatedSprite2D.play("Walking")
	if (direction=="W"):
		speed*=-1
		$AnimatedSprite2D.flip_h=true

	
func _process(delta):
	super._process(delta)
	if (isMoving):
		move(speed)
	if (playerInside):
		if Input.is_action_pressed("Attack1"):
			call_deferred("free")


func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Doors"):
		isMoving=false
		$AnimatedSprite2D.play("Attacking")
	elif (area.get_parent().name=="Player"):
		playerInside=true


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerInside=false
