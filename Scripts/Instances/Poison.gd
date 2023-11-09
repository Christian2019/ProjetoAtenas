extends Node2D

var speed
var damage
var worm
var target



func _process(delta):
		
	move()
		
	if (global_position.y>1225):
		queue_free()


func move():
	var moveAngle= global_position.angle_to_point(target)
	if (global_position.distance_to(target)<speed):
		queue_free()
		return
		
	global_position.x+=speed*cos(moveAngle)
	global_position.y+=speed*sin(moveAngle)


func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player" or area.get_parent().name=="Center"):
		var enemy = area.get_parent()
		enemy.hp-=damage
		enemy.activateFeedback()
		queue_free()


