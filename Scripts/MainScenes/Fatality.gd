extends Node2D

func _ready():
	$FadeIn.play("FadeIn")   


func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn")


func _on_fade_in_animation_finished(anim_name):
	$ColorRect.queue_free()
	$Retry.grab_focus()


func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

