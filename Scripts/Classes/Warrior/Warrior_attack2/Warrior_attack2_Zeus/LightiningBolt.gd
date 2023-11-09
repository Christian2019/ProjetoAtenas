extends Node2D

var speed=40
var angle
var damage
var target

func _ready():
	global_position=Vector2(target.global_position.x,0)


func _process(delta):
	if !(is_instance_valid(target)):
		destroy()
		return
	getAngle()
	move()
	applyDamage()
	
	
func destroy():
	queue_free()

func getAngle():
	angle=rad_to_deg(global_position.angle_to_point(target.global_position))
	$AnimatedSprite2D.rotation_degrees=angle

func move():
	global_position.x+=speed*cos(deg_to_rad(angle))
	global_position.y+=speed*sin(deg_to_rad(angle))

func applyDamage():
	if  global_position.distance_to(target.global_position)<speed:
		Global.MathController.damageController(damage,target)
		destroy()
