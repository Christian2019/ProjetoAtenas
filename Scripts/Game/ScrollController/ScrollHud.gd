extends Node2D

func _ready():
	Global.ScrollController.scrollHuds.append({"scrollHud":self})
	for i in range(0,$Scrolls.get_child_count(),1):
		var s =$Scrolls.get_child(i)
		s.get_node("Big").visible=false
		s.get_node("Small").visible=true

