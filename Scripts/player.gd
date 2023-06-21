extends Node2D

var speed = 5

func _ready():
	$Animation.play("Right")



func _process(delta):
	animationController()
	moveController()	

func animationController():
	if Input.is_action_pressed("Move_Down"):
		$Animation.play("Down")
	elif Input.is_action_pressed("Move_Up"):
		$Animation.play("Up")
	elif Input.is_action_pressed("Move_Right"):
		$Animation.play("Right")
	elif Input.is_action_pressed("Move_Left"):
		$Animation.play("Left")
	else:
		$Animation.stop()
		
		
	
func moveController():
	if Input.is_action_pressed("Move_Down"):
		position.y+=speed
	elif Input.is_action_pressed("Move_Up"):
		position.y-=speed
	elif Input.is_action_pressed("Move_Right"):
		position.x+=speed
	elif Input.is_action_pressed("Move_Left"):
		position.x-=speed
