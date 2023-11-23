extends Node


var Fullscreen = false
var Resolution = Vector2(1280,720)
var MasterVolume
var MusicVolume
var Resolution_selected = 1


# Called when the node enters the scene tree for the first time.
func _ready():  
	MasterVolume = -12
	MusicVolume = 0
	get_window().mode=Window.MODE_WINDOWED
	get_window().size=Resolution
	pass # Replace with function body.

 
