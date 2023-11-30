extends Node2D
 
var can_break = true
var damage_mining = 0.5 

func _ready():
	Global.PlayerMining = self

func mining(farming,playerRight,closerQuadrant):
		if (!farming):
			return
		
		if Input.is_action_pressed("Attack1") and can_break: 
			if (playerRight):
				Global.player.get_node("CutAnimation").flip_h=false
			else:
				Global.player.get_node("CutAnimation").flip_h=true 
			Global.player.get_node("CutAnimation").play()   
			
			if closerQuadrant!=null:
				if closerQuadrant.get_node("Resource").visible:
					closerQuadrant.life_till_break -= damage_mining  
					can_break=false 
					Global.timerCreator("activateBreak",0.5,[],self)
					if(closerQuadrant.life_till_break <= 0):
						closerQuadrant.get_node("Resource").visible=false 
						
						var collectable_instance = PreLoads.collectable.instantiate()
						collectable_instance.value=closerQuadrant.value
						
						if (closerQuadrant.get_node("Resource").animation=="wood"):
							collectable_instance.get_node("AnimatedSprite2D").animation="wood"
						
						if (closerQuadrant.get_node("Resource").animation=="gold"):
							collectable_instance.get_node("AnimatedSprite2D").animation="gold"
						
						if (closerQuadrant.get_node("Resource").animation=="stone"):
							collectable_instance.get_node("AnimatedSprite2D").animation="stone"
						
						collectable_instance.global_position=closerQuadrant.get_node("Resource").global_position
						Global.Game.get_node("Instances/Collectable_instances").add_child(collectable_instance)	  


func activateBreak():
		can_break=true
