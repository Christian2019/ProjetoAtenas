extends Node2D

var areaPlayerEnter=false

func _process(delta):
	if areaPlayerEnter:
		if Input.is_action_just_pressed("Select"):
			get_tree().paused = true
			Global.Temple.visible=true
			Global.Temple.get_node("BG/SHOP").scrollsSelect()
			
			

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		areaPlayerEnter=true
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

func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		areaPlayerEnter=false
