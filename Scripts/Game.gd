extends Node2D

var start_b = true
func start():
	if (start_b):
		start_b = false
		Global.Game = self



func _process(_delta):
	start()

