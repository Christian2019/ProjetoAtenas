extends Node2D

var centerPoint

func _ready():
	centerPoint = get_parent().get_parent().get_node("Center/CenterArea/CollisionShape2D")

func _process(delta):
	pass

