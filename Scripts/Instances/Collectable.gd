extends Node2D

var isCarrying=false

var value

func _process(_delta):
	if (isCarrying):
		global_position=Global.player.global_position

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		var player = area.get_parent() 
		if(player.itemsCarriage.size() < player.MaxCarriage and not player.itemsCarriage.has(self)): 
			player.itemsCarriage.append(self)
			visible=true  
			var animatedSprite=$AnimatedSprite2D
			match(player.itemsCarriage.size()):
				1:
					animatedSprite.position.x = 0
					animatedSprite.position.y = 20
					pass
				2:
					animatedSprite.position.x = -15
					animatedSprite.position.y = 4.5
					pass
				3:
					animatedSprite.position.x = 0 
					pass
				4:
					animatedSprite.position.x = 15
					animatedSprite.position.y = 4.5
					pass
				5:
					animatedSprite.position.x = 0
					animatedSprite.position.y = -20
					pass
			get_parent().call_deferred("remove_child",self)
			player.call_deferred("add_child",self)
			isCarrying=true
