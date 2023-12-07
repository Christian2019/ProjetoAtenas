extends Node2D

var damage

func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		Global.MathController.damageController(damage,area.get_parent())


func _on_animated_sprite_2d_animation_looped():
	queue_free()
