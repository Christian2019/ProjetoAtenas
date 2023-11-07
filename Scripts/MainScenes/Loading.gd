extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Musica.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	Global.timerCreator("startGame",3,[],self) 
	$Loading.play("default")


func startGame():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Game_ViewPort.tscn") 
 
