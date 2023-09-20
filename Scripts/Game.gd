extends Node2D

var start_b = true
func start():
	if (start_b):
		start_b = false
		Global.Game = self


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	start()
