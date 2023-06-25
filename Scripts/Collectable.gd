extends Node2D

var isCarrying=false


func _process(delta):
	if (isCarrying):
		global_position=Global.player.global_position

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		var player = area.get_parent()
		if (player.carryingItem==null):
			player.carryingItem=self
			visible=true
			get_parent().call_deferred("remove_child",self)
			player.call_deferred("add_child",self)
			isCarrying=true
