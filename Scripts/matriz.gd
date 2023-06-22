extends Node2D

var quadrant = preload("res://Scenes/quadrant.tscn")
var start = false

func _process(delta):
	if (!start):
		start = true
		for linha in range(0,43,1):
			for coluna in range(0,40,1):
				var quadrant_instance = quadrant.instantiate()
				quadrant_instance.name = str("linha", linha , "_coluna", coluna)
				quadrant_instance.position= Vector2(64*coluna,64*linha)
				add_child(quadrant_instance)
