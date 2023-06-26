extends Node2D

var speed = 5

var wood =0
var stone =0
var gold =0

var carryingItem

var playerRight=true

var contactQuadrants = []

var closerQuadrant 
#{vector2,index}

func _ready():
	$Animation.play("Right")
	

var start_b = true
func start():
	if (start_b):
		start_b = false
		Global.player = self
	

func _process(delta):
	start()
	animationController()
	moveController()	
	getCloserQuadrant()
	mining()

func mining():
	if Input.is_action_pressed("Select"):
		if (playerRight):
			$CutAnimation.flip_h=false
		else:
			$CutAnimation.flip_h=true
		$CutAnimation.play()
		if closerQuadrant!=null:
			if closerQuadrant.get_node("Resource").visible:
				closerQuadrant.get_node("Resource").visible=false
				var collectable_instance = PreLoadeds.collectable.instantiate()
				
				if (closerQuadrant.get_node("Resource").animation=="wood"):
					collectable_instance.get_node("AnimatedSprite2D").animation="wood"
				elif (closerQuadrant.get_node("Resource").animation=="gold"):
					collectable_instance.get_node("AnimatedSprite2D").animation="gold"
				elif (closerQuadrant.get_node("Resource").animation=="stone"):
					collectable_instance.get_node("AnimatedSprite2D").animation="stone"
				
				collectable_instance.global_position=closerQuadrant.get_node("Resource").global_position
				get_parent().get_node("Collectable_instances").add_child(collectable_instance)
	
				
func getCloserQuadrant():
	for i in range(0,contactQuadrants.size(),1):
		contactQuadrants[i].get_node("ColorRect").visible=false
		if (closerQuadrant==null):
			closerQuadrant=contactQuadrants[i]
		elif(position.distance_to(contactQuadrants[i].position)<position.distance_to(closerQuadrant.position)):
			closerQuadrant.get_node("ColorRect").visible=false
			closerQuadrant=contactQuadrants[i]
	if (closerQuadrant!=null):
		closerQuadrant.get_node("ColorRect").visible=true	
	
func animationController():
	if ($CutAnimation.frame==6):
		$CutAnimation.frame=0
		$CutAnimation.stop()
	if Input.is_action_pressed("Move_Down"):
		$Animation.play("Down")
	elif Input.is_action_pressed("Move_Up"):
		$Animation.play("Up")
	elif Input.is_action_pressed("Move_Right"):
		$Animation.play("Right")
	elif Input.is_action_pressed("Move_Left"):
		$Animation.play("Left")
	else:
		$Animation.stop()
		
		
	
func moveController():
	if Input.is_action_pressed("Move_Down"):
		position.y+=speed
	elif Input.is_action_pressed("Move_Up"):
		position.y-=speed
	elif Input.is_action_pressed("Move_Right"):
		playerRight=true
		position.x+=speed
	elif Input.is_action_pressed("Move_Left"):
		playerRight=false
		position.x-=speed


func _on_timer_timeout():
	pass
