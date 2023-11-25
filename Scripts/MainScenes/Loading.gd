extends Node2D

func _ready():
	$Musica.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	ResourceLoader.load_threaded_request("res://Scenes/MainScenes/Game_ViewPort.tscn")

func _process(delta):
	if ResourceLoader.load_threaded_get_status("res://Scenes/MainScenes/Game_ViewPort.tscn")==ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		var g : PackedScene = ResourceLoader.load_threaded_get("res://Scenes/MainScenes/Game_ViewPort.tscn")
		get_tree().change_scene_to_packed(g)


