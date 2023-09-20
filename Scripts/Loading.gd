extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.timerCreator("startGame",3,[],self)


func startGame():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Game_ViewPort.tscn")
