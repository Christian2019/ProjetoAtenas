extends Node2D

var speed=16
var angle
var damage=1000
var target
var targetIndex=0
var extraBounces=0

	
func getCloserEnemy():
	var enemies= Global.Game.get_node("Enemies").get_children()
	if (targetIndex>extraBounces or enemies.size()<2):
		queue_free()
		return
		
	targetIndex+=1
	var closerEnemy=null
	for i in range(0,enemies.size(),1):
		var enemy = enemies[i]
		
		if is_instance_valid(target):
			if (enemy==target):
				continue
				
		if (closerEnemy==null):
			closerEnemy=enemy
		elif (enemy.global_position.distance_to(global_position)<closerEnemy.global_position.distance_to(global_position)):
			closerEnemy=enemy
	
	if (closerEnemy==null):
		queue_free()
	else:
		target=closerEnemy


func _process(delta):
	move()
	getAngle()

func getAngle():
	if !(is_instance_valid(target)):
		queue_free()
		return
	angle=rad_to_deg(global_position.angle_to_point(target.global_position))
	$AnimatedSprite2D.rotation_degrees=angle

func move():
	if !(is_instance_valid(target)):
		getCloserEnemy()
		return
		
	if  global_position.distance_to(target.global_position)<speed:
		
		Global.MathController.damageController(damage,target)
		getCloserEnemy()
		return
		
	global_position.x+=speed*cos(deg_to_rad(angle))
	global_position.y+=speed*sin(deg_to_rad(angle))
