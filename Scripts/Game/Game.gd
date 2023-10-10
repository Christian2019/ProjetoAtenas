extends Node2D

var start_b = true
func start():
	if (start_b):
		start_b = false
		Global.Game = self



func _process(_delta):
	start()
	if (Input.is_action_just_pressed("zoomOut")):
		Global.camera.zoom.x=0.5
		Global.camera.zoom.y=0.5

	if (Input.is_action_just_pressed("zoomIn")):
		Global.camera.zoom.x=1
		Global.camera.zoom.y=1
