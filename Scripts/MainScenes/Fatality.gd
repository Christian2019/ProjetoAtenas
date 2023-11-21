extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$FadeIn.play("FadeIn")   
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if (!$VideoStreamPlayer.is_playing()):
		#get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")
	pass

func _on_retry_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn")
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")
	pass # Replace with function body.

 

func _on_fade_in_animation_finished(anim_name):
	$ColorRect.queue_free()
	$RETRY.grab_focus()
	pass # Replace with function body.
