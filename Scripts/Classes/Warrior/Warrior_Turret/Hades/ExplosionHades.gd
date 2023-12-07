extends Node2D

var damage
var area=1

func _ready():
	$AnimatedSprite2D.scale*=Vector2(area,area)
	

func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		Global.MathController.damageController(damage,area.get_parent())


func _on_animated_sprite_2d_animation_looped():
	queue_free()
