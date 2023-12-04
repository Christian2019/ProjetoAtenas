extends Node2D

func _ready():
	Global.ScrollController.scrollHuds.append({"scrollHud":self})
	$Selected.get_child(0).get_node("Big").visible=true
	$Selected.get_child(0).get_node("Small").visible=false

