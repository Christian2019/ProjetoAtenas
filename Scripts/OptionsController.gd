extends Node


var Fullscreen = false
var Resolution = Vector2(1280,720)
var MasterVolume
var MusicVolume

# Called when the node enters the scene tree for the first time.
func _ready(): 
	MusicVolume = -12
	MasterVolume = -12
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Fullscreen==false):
		get_window().mode=Window.MODE_WINDOWED
		get_window().size=Resolution
	else:
		get_window().mode= Window.MODE_FULLSCREEN
	pass
