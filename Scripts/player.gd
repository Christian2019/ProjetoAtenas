extends Node2D
##Stats
var move_Speed = 5
var attack_Speed = 1 ## precisa ser >0

var playerClass = PreLoads.warrior

##Abilities Var

##Type Normal Zeus...
var attack1_type = "Normal"
var attack2_type = "Normal"
var turret_type = "Normal"
var dash_type = "Normal"
var ultimate_type = "Normal"

## Se esta em CD
var permissions = [
	{"attack1_canUse" : true},
	{"attack2_canUse" : true},
	{"turret_canUse" : true},
	{"dash_canUse" : true},
	{"ultimate_canUse" : true},
	]

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
	commandController()	
	getCloserQuadrant()
	#mining()
	#contruction()

func commandController():
	moveController()
	attack1Controller()
	attack2Controller()
	turretController()
	dashController()
	ultimateController()
	
func creatAttackInstance(classChild):
	##Criando uma instancia do tipo do ataque da classe
	var classInstance = playerClass.instantiate()
	var attackInstance=classInstance.get_child(classChild)
	classInstance.remove_child(attackInstance)
	classInstance.queue_free()
	
	##Bloqueando o uso da skill pelo cd da skill / tua attack speed
	permissions[classChild]=false
	Global.timerCreator("enableAttackUse",attackInstance.cd/attack_Speed,[classChild],self)	
	
	return attackInstance
   
func enableAttackUse(classChild):
	permissions[classChild]=true
	
	
func attack1Controller():
	var classChild=0	
	if (Input.is_action_pressed("Attack1") and permissions[classChild]):
		var attackInstance = creatAttackInstance(classChild)
		get_parent().get_node("Projectiles").add_child(attackInstance)
		attackInstance.global_position=global_position
		attackInstance.get_node("Animation").play()

		
		
func attack2Controller():
	if (Input.is_action_just_pressed("Attack2")):
		print("Attack2")
func turretController():
	if (Input.is_action_just_pressed("Turret")):
		print("Turret")
func dashController():
	if (Input.is_action_just_pressed("Dash")):
		print("Dash")
		##$Animation.modulate.a = 0.5
func ultimateController():
	if (Input.is_action_just_pressed("Ultimate")):
		print("Ultimate")

func contruction():
	if (Input.is_action_just_pressed("Turret")):
		if (closerQuadrant!=null and closerQuadrant.allowToConstruct):
			var tower_instance = PreLoads.tower.instantiate()
			tower_instance.position = closerQuadrant.position
			closerQuadrant.tower = tower_instance
			get_parent().get_node("Towers").add_child(tower_instance)
	

func mining():
	if Input.is_action_pressed("Attack1"):
		if (playerRight):
			$CutAnimation.flip_h=false
		else:
			$CutAnimation.flip_h=true
		$CutAnimation.play()
		if closerQuadrant!=null:
			if closerQuadrant.get_node("Resource").visible:
				closerQuadrant.get_node("Resource").visible=false
				var collectable_instance = PreLoads.collectable.instantiate()
				
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
	var speedModifier=1
	if Input.is_action_pressed("Move_Down") or Input.is_action_pressed("Move_Up"):
		if Input.is_action_pressed("Move_Right") or Input.is_action_pressed("Move_Left"):
			speedModifier=1/(2**0.5)			
	
	if Input.is_action_pressed("Move_Down"):
		position.y+=move_Speed*speedModifier
	elif Input.is_action_pressed("Move_Up"):
		position.y-=move_Speed*speedModifier
	if Input.is_action_pressed("Move_Right"):
		playerRight=true
		position.x+=move_Speed*speedModifier
	elif Input.is_action_pressed("Move_Left"):
		playerRight=false
		position.x-=move_Speed*speedModifier


func _on_timer_timeout():
	pass
