extends Node2D

var areaPlayerEnter=false


func _process(delta):
	if areaPlayerEnter:
		if Input.is_action_just_pressed("Select"): 
			Global.TempleScreen.visible=true
			get_tree().paused = true
			print(get_tree())
			
	

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		areaPlayerEnter=true
		var player = area.get_parent()  
		if(player.itemsCarriage.size() > 0): 
			for i in range(0,player.itemsCarriage.size()):
				if(player.itemsCarriage[0].get_node("AnimatedSprite2D").animation == "wood"):
					player.wood+=1
				elif(player.itemsCarriage[0].get_node("AnimatedSprite2D").animation == "stone"):
					player.stone+=1
				elif(player.itemsCarriage[0].get_node("AnimatedSprite2D").animation == "gold"):
					player.gold+=1 
				player.call_deferred("remove_child",player.itemsCarriage[0]) 
				player.itemsCarriage.erase(player.itemsCarriage[0])


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		areaPlayerEnter=false
