extends Node2D


var canGrab = 0
var position_board= Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var get_parent = get_parent() 
	pass


func _on_area_select_mouse_entered():
	canGrab=1
	pass # Replace with function body.


func _on_area_select_mouse_exited():
	canGrab=0
	pass # Replace with function body.
