extends Node2D

var frame=0
var duration=10
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (frame==duration):
		queue_free()
		return
	modulate.a = 1-float(frame)/float(duration)
	
	frame+=1
