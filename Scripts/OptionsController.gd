extends Node


var Fullscreen = false
var Resolution = Vector2(1280,720)
var MasterVolume
var MusicVolume


# Called when the node enters the scene tree for the first time.
func _ready(): 
	MusicVolume = -12
	MasterVolume = -12
	get_window().mode=Window.MODE_WINDOWED
	get_window().size=Resolution
	pass # Replace with function body.

 
