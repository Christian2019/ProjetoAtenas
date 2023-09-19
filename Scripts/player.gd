extends Node2D
##Stats
var move_Speed = 10
var attack_Speed = 1 ## precisa ser >0

var playerClass = PreLoads.warrior

#Controle do ultimo movimento, pode ser N,S,W,E,NE,NW,SE,SW. Usado para controle da direacao do ataque
var lastMovement = "E"

##Abilities Var

var actions = [
	{"attack1_type" : 0},
	{"attack2_type" : 0},
	{"turret_type" : 0},
	{"dash_type" : 0},
	{"ultimate_type" : 0},
	]

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

var farming =false

func _ready():
	$Animation.play("Right")


var start_b = true
func start():
	if (start_b):
		start_b = false
		Global.player = self
	

func _process(__delta):
	start()
	animationController()
	commandController()	
	getCloserQuadrant()
	debug()
	mining()
	#contruction()
func debug():
	if Input.is_action_just_pressed("ChangeAttack1"):
		actions[0]={"attack1_type" : actions[0].values()[0]+1}
		if (actions[0].values()[0]==3):
			actions[0]={"attack1_type" : 0}
			
func commandController():
	moveController()
	if (farming):
		return
	attack1Controller()
	attack2Controller()
	turretController()
	dashController()
	ultimateController()
	
func creatAttackInstance(classChild):
	##Criando uma instancia do tipo do ataque da classe
	var attackInstance = playerClass[classChild].instantiate()

	##Bloqueando o uso da skill pelo cd da skill / tua attack speed
	permissions[classChild]=false
	
	#Global.timerCreator("enableAttackUse",attackInstance.cd/attack_Speed,[classChild],self)	
	
	attackInstance.attacktype=actions[classChild].values()[0]

	return attackInstance
   
func enableAttackUse(classChild):
	permissions[classChild]=true
	
	
func attack1Controller():
	var classChild=0	
	if (Input.is_action_pressed("Attack1") and permissions[classChild]):
		var attackInstance = creatAttackInstance(classChild)
		get_parent().get_node("Projectiles").add_child(attackInstance)
		attackInstance.global_position=global_position
		attackInstance.direction=lastMovement

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
	if (!farming):
		return
		
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
		#position.y+=move_Speed*speedModifier
		tryToMove(0,move_Speed*speedModifier)
	elif Input.is_action_pressed("Move_Up"):
		#position.y-=move_Speed*speedModifier
		tryToMove(0,move_Speed*speedModifier*(-1))
	if Input.is_action_pressed("Move_Right"):
		playerRight=true
		#position.x+=move_Speed*speedModifier
		tryToMove(move_Speed*speedModifier,0)
	elif Input.is_action_pressed("Move_Left"):
		playerRight=false
		#position.x-=move_Speed*speedModifier
		tryToMove(move_Speed*speedModifier*(-1),0)

		
	lastMoveController()

func tryToMove(speedX,speedY):
	var topSpeed = 150
	if (abs(speedX)>topSpeed):
		speedX=speedX*topSpeed/abs(speedX)
	if (abs(speedY)>topSpeed):
		speedY=speedY*topSpeed/abs(speedY)
		
	var nextTryPosition = Vector2(position.x+speedX,position.y+speedY)
	if (!Global.areaBoxCollision(self,nextTryPosition,$Body,Global.Game.get_node("BockedAreas").get_children())):
		position.y+=speedY
		position.x+=speedX
	else:
		#Faz o movimento limitando a velocidade para que encaixe perfeitamente
		
		var testSpeedStep=0.01
		var testSpeedValue=testSpeedStep
		nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		while (!Global.areaBoxCollision(self,nextTryPosition,$Body,Global.Game.get_node("BockedAreas").get_children())):
			testSpeedValue+=testSpeedStep
			nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		testSpeedValue-=testSpeedStep
		position.y+=speedY*testSpeedValue
		position.x+=speedX*testSpeedValue
		
	

func lastMoveController():

	if Input.is_action_pressed("Move_Down"):
		lastMovement="S"
		if Input.is_action_pressed("Move_Right"):
			lastMovement="SE"
		elif Input.is_action_pressed("Move_Left"):
			lastMovement="SW"
	elif Input.is_action_pressed("Move_Up"):
		lastMovement="N"
		if Input.is_action_pressed("Move_Right"):
			lastMovement="NE"
		elif Input.is_action_pressed("Move_Left"):
			lastMovement="NW"
	elif Input.is_action_pressed("Move_Right"):
		lastMovement="E"
	elif Input.is_action_pressed("Move_Left"):
		lastMovement="W"
		

func _on_timer_timeout():
	pass
