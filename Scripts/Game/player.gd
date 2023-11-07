extends Node2D

var dead = false

var fx_Attack2

##Stats
var maxHp=99999
var hp = maxHp
var hpRegeneration=0
var lifeStealChance=0.1
var percentDamage=1.0
var baseDamage=1.0
var attack_Speed = 1.0
var percentCritDamage=0.1
var armor=20
var dodge=50
var maxDodge=70
var move_Speed = 5.0
var luck=0
var collect_radios=200

#Controle do ultimo movimento, pode ser N,S,W,E,NE,NW,SE,SW. Usado para controle da direacao do ataque
var lastMovement = "E"

##Skills Ativos
var attack1={"skill":PreLoads.warrior_attack1_zeus, "quality": "legendary"}
var attack2={"skill":PreLoads.warrior_attack2_noGod, "quality": "common"}
var turret={"skill":PreLoads.warrior_turret_zeus, "quality": "common"}
var dash={"skill":PreLoads.warrior_dash_noGod, "quality": "common"}
var ultimate={"skill":PreLoads.warrior_ultimate_poseidon, "quality": "legendary"}
var ultimateMaxActivations=5
var ultimateWaveActivations=0
#Passivos


## Se esta em CD
var permissions = [
	{"attack1_canUse" : true},
	{"attack2_canUse" : true},
	{"turret_canUse" : true},
	{"dash_canUse" : true},
	{"ultimate_canUse" : true},
	]

#Resources
var wood =0
var stone =0
var gold =0
var dracma=0
var dracmaBag=0

#Farming
var carryingItem

var contactQuadrants = []
var closerQuadrant 

var farming =false
var playerOnCenterPoint=false
var dashing = false
var playerRight=true

##Feedback por levar dano ou curar
var feedBackAtive=false
var reverseAlphaChange=false

var animAttacking=false

func _ready():
	Global.player = self
	fx_Attack2 = $VFX_attack2
	fx_Attack2.set_visible(false)

func _process(_delta):
	if (dead):
		return
	
	if (hp<=0):
		hp=0
		dead=true
		restartGame()
		return
	
	animationController()
	commandController()
	getCloserQuadrant()
	
	mining()
	feedback()
	
	
	
	#contruction()

func restartGame():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Fatality.tscn")
	
func animationController():
	if (dashing):
		return
	
	if (animAttacking):
		if $Animation.frame>3 and !permissions[0]:
			animAttacking = true
		
		return
	
	
	if ($CutAnimation.frame==6):
		$CutAnimation.frame=0
		$CutAnimation.stop()
	
	if Input.is_action_pressed("Move_Down") and Input.is_action_pressed("Move_Right"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Down") and Input.is_action_pressed("Move_Left"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Up") and Input.is_action_pressed("Move_Right"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Up") and Input.is_action_pressed("Move_Left"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Down"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Up"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Right"):
		playAnimation ("Run", $Animation)
	elif Input.is_action_pressed("Move_Left"):
		playAnimation ("Run", $Animation)
	else:
		playAnimation ("Idle", $Animation)
		
func playAnimation (animName, animNode):
	if lastMovement=="S":
		animNode.play(animName+"_Down")
	elif lastMovement=="SE":
		animNode.play(animName+"_Down_Right")
	elif lastMovement=="SW":
		animNode.play(animName+"_Down_Left")
	elif lastMovement=="N":
		animNode.play(animName+"_Up")
	elif lastMovement=="NE":
		animNode.play(animName+"_Up_Right")
	elif lastMovement=="NW":
		animNode.play(animName+"_Up_Left")
	elif lastMovement=="E":
		animNode.play(animName+"_Right")
	elif lastMovement=="W":
		animNode.play(animName+"_Left")
	
	if (animName=="Run"):
		$Animation.speed_scale=move_Speed/5
		

func commandController():
	if (dashing):
		return
	
	moveController()
	
	if (farming or playerOnCenterPoint or Global.Game.get_node("WaveController").mining):
		return
	
	attack1Controller()
	attack2Controller()
	turretController()
	dashController()
	ultimateController()
	
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
	if (!Global.areaBoxCollision(self,nextTryPosition,$Body,Global.Game.get_node("Zones/BockedAreas").get_children())):
		position.y+=speedY
		position.x+=speedX
		return true
	else:
		#Faz o movimento limitando a velocidade para que encaixe perfeitamente
		
		var testSpeedStep=0.01
		var testSpeedValue=testSpeedStep
		nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		while (!Global.areaBoxCollision(self,nextTryPosition,$Body,Global.Game.get_node("Zones/BockedAreas").get_children())):
			testSpeedValue+=testSpeedStep
			nextTryPosition = Vector2(position.x+speedX*testSpeedValue,position.y+speedY*testSpeedValue)
		
		testSpeedValue-=testSpeedStep
		position.y+=speedY*testSpeedValue
		position.x+=speedX*testSpeedValue
		return false
		
func lastMoveController():
	if Input.is_action_pressed("Move_Down") and Input.is_action_pressed("Move_Right"):
		lastMovement="SE"
	elif Input.is_action_pressed("Move_Down") and Input.is_action_pressed("Move_Left"):
		lastMovement="SW"
	elif Input.is_action_pressed("Move_Up") and Input.is_action_pressed("Move_Right"):
		lastMovement="NE"
	elif Input.is_action_pressed("Move_Up") and Input.is_action_pressed("Move_Left"):
		lastMovement="NW"
	elif Input.is_action_pressed("Move_Down"):
		lastMovement="S"
	elif Input.is_action_pressed("Move_Up"):
		lastMovement="N"
	elif Input.is_action_pressed("Move_Right"):
		lastMovement="E"
	elif Input.is_action_pressed("Move_Left"):
		lastMovement="W"
	
	"""
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
		"""
	

   
func enableAttackUse(classChild):
	permissions[classChild]=true

func attack1Controller():
	if (Global.MathController.attack1_poseidon.heavyDamageOn):
		return
	var classChild=0	
	if (Input.is_action_pressed("Attack1") and permissions[classChild]):
		var attackInstance = creatAttackInstance(classChild)
		Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
		attackInstance.global_position=global_position
		attackInstance.direction=lastMovement
		
		playAnimation ("Attack1" , $Animation)
		animAttacking=true
		$Animation.speed_scale=attack_Speed
	

func creatAttackInstance(classChild):
	##Criando uma instancia do tipo do ataque da classe
	var attackInstance
	
	if (classChild==0):
		attackInstance= attack1.skill.instantiate()
		attackInstance.quality= attack1.quality
	elif(classChild==1):
		attackInstance= attack2.skill.instantiate()
		attackInstance.quality= attack2.quality
	elif(classChild==2):
		attackInstance= turret.skill.instantiate()
		attackInstance.quality= turret.quality
	elif(classChild==3):
		attackInstance= dash.skill.instantiate()
		attackInstance.quality= dash.quality
	elif(classChild==4):
		attackInstance= ultimate.skill.instantiate()
		attackInstance.quality= ultimate.quality

	##Bloqueando o uso da skill pelo cd da skill / tua attack speed
	permissions[classChild]=false

	return attackInstance

func attack2Controller():
	var classChild=1	
	if (Input.is_action_pressed("Attack2") and permissions[classChild]):
		var attackInstance = creatAttackInstance(classChild)
		Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
		attackInstance.global_position=global_position
		attackInstance.direction=lastMovement
		
		playAnimation ("Attack2", $Animation)
		animAttacking=true
		$Animation.speed_scale=attack_Speed
		
		fx_Attack2.set_visible(true)
		playAnimation("Normal", fx_Attack2)
		
		
func turretController():
	var classChild=2	
	if (Input.is_action_just_pressed("Turret")):
		print("Turret")
		var attackInstance = creatAttackInstance(classChild)
		Global.Game.get_node("Instances/Turrets").add_child(attackInstance)
		attackInstance.global_position=global_position

func dashController():
	var classChild=3	
	if (Input.is_action_just_pressed("Dash") and permissions[classChild]):
		#print("Dash")
		var attackInstance = creatAttackInstance(classChild)
		attackInstance.direction= lastMovement
		add_child(attackInstance)
		playAnimation("Dash", $Animation)
		enableDisableAnimation()
		
func enableDisableAnimation():
	if($Animation.is_playing()):
		$Animation.stop()
	else:
		$Animation.play()	
		
func ultimateController():
	var classChild=4	
	if (Input.is_action_just_pressed("Ultimate") and permissions[classChild] and ultimateWaveActivations<ultimateMaxActivations):
		print("Ultimate")
		ultimateWaveActivations+=1
		var attackInstance = creatAttackInstance(classChild)
		Global.Game.get_node("Instances/Ultimates").add_child(attackInstance)
		attackInstance.global_position=global_position
	
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
				Global.Game.get_node("Instances/Collectable_instances").add_child(collectable_instance)	

func feedback():
	if (feedBackAtive):
		var feedbackSpeed=0.04
		if (!reverseAlphaChange):
			modulate.a -= feedbackSpeed
			if (modulate.a<=0.0):
				reverseAlphaChange=true
		else:
			modulate.a += feedbackSpeed
			if (modulate.a>=1):
				reverseAlphaChange=false

func activateFeedback():
	if (!feedBackAtive):
		feedBackAtive=true
		Global.timerCreator("disableFeeback",1,[],self)
		
func disableFeeback():
	feedBackAtive=false
	modulate.a=1

func contruction():
	if (Input.is_action_just_pressed("Turret")):
		if (closerQuadrant!=null and closerQuadrant.allowToConstruct):
			var tower_instance = PreLoads.tower.instantiate()
			tower_instance.position = closerQuadrant.position
			closerQuadrant.tower = tower_instance
			get_parent().get_node("Towers").add_child(tower_instance)

func _on_body_area_entered(area):
	if area.get_parent().name == "Center":
		playerOnCenterPoint=true


func _on_body_area_exited(area):
	if area.get_parent().name == "Center":
		playerOnCenterPoint=false


func _on_timer_timeout():
	return 
	print("STATUS:")
	print("hpRegeneration: ",hpRegeneration)
	print("lifesteal: ",lifeStealChance)
	print("percentDamage: ",percentDamage)
	print("baseDamage: ",baseDamage)
	print("attackspeed: ",attack_Speed)
	print("percentCritDamage: ",percentCritDamage)
	print("armor: ",armor)
	print("dodge: ",dodge)
	print("move_Speed: ",move_Speed)
	print("luck: ",luck)
	print("collect_radios: ",collect_radios)


func _on_animation_animation_looped():
	if (animAttacking):
		animAttacking=false



func _on_vfx_attack_2_animation_looped():
	if (animAttacking):
		animAttacking=false
		fx_Attack2.set_visible(false)
