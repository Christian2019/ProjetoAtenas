extends Node2D

var speed=4
var angle
var damage=10

func _ready():
	$AnimatedSprite2D.rotation_degrees=angle
	


func _process(delta):
	global_position.x+=speed*cos(deg_to_rad(angle))
	global_position.y+=speed*sin(deg_to_rad(angle))


func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player" or area.get_parent().name=="Center"):
		var enemy = area.get_parent()
		enemy.hp-=damage
		enemy.activateFeedback()
		queue_free()
	if (area.name=="BockedAreas"):
		queue_free()
		
