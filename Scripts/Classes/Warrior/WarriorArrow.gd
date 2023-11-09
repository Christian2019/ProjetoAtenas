extends Node2D


var speed=10
var angle
var damage

func _ready():
	rotation_degrees=angle
	animation()


func animation():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible=true
	$AnimatedSprite2D.frame=0


func _process(delta):
	position.x+=speed*cos(deg_to_rad(angle))
	position.y+=speed*sin(deg_to_rad(angle))


func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		var enemy = area.get_parent()
		enemy.hp-=damage
