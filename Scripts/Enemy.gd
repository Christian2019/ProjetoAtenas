extends Node2D

var direction

func _ready():
	pass


func _process(delta):
	pass


func move(speed):
	if (direction=="S"):
		position.y+=speed
	else:
		position.x+=speed
