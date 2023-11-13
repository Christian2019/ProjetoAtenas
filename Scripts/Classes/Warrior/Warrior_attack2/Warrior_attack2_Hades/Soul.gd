extends Node2D

var maxHP

var speed=5.0
var aceleration=1.0/60

func _process(delta):
	speed+=aceleration
	global_position+= Vector2(speed*cos(global_position.angle_to_point(Global.player.global_position)),speed*sin(global_position.angle_to_point(Global.player.global_position)))
	if (global_position.distance_to(Global.player.global_position)<speed):
		Global.player.baseMaxHp+=maxHP
		queue_free()
