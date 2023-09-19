extends Node2D



func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		var player = area.get_parent()
		if (player.carryingItem!=null):
			if (player.carryingItem.get_node("AnimatedSprite2D").animation=="wood"):
				player.wood+=1
			elif (player.carryingItem.get_node("AnimatedSprite2D").animation=="stone"):
				player.stone+=1
			elif (player.carryingItem.get_node("AnimatedSprite2D").animation=="gold"):
				player.gold+=1	
				
			player.call_deferred("remove_child",player.carryingItem)
			player.carryingItem=null
	

