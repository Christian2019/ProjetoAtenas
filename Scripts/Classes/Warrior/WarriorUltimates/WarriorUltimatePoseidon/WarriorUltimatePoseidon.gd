extends Node2D

var quality="legendary"

#Duracao em segundos
var cd = 5

var frame=0
var max_duration = 15

var maxWaveScale

var maxKnockback=10000
var knockBackSpeed=5
#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var damage = 1000
var tentaclesQuantity
var krakenAlly

func _ready():
	$Sprite2D.modulate.a=0
	$Sprite2D2.visible=false
	Global.Game.get_node("Night").visible=true
	$AnimatedSprite2D.modulate.a=0.2
	Global.timerCreator("destroy", max_duration,[],self)
	qualityStatus()
	maxWaveScale=$AnimatedSprite2D.scale

func qualityStatus():
	#Cooldown: 60/20/5/5/5s Max activations per wave 1/2/2/3/4
	if ( quality=="common"):
		cd=5
	elif ( quality=="legendary"):
		cd=5
		tentaclesQuantity=5
		$Sprite2D2.visible=true
		$Sprite2D2.modulate.a=0
		$AudioStreamPlayer.play()
		createTentacles()
		
func createTentacles():
	var kraken = Node2D.new()
	Global.Game.get_node("Allies").add_child(kraken)
	for i in range(0,tentaclesQuantity,1):
		var tentacle = PreLoads.poseidon_tentacle.instantiate()
		var spawnPosition=getAllowRandomSpawnPosition(tentacle)
		var turret = Global.player.turret.skill.instantiate()
		turret.quality= Global.player.turret.quality
		kraken.add_child(turret)
		kraken.add_child(tentacle)
		tentacle.global_position=spawnPosition
		turret.global_position=tentacle.get_node("TurretPosition").global_position
		turret.get_node("Animations").visible=false
	krakenAlly=kraken
	

func getAllowRandomSpawnPosition(tentacle):
	var rng = RandomNumberGenerator.new()
	var x = rng.randi_range(50, 2450)
	var y = rng.randi_range(50, 1225)
	if !tryFit(x,y,tentacle):
		return getAllowRandomSpawnPosition(tentacle)
	return Vector2(x,y)

func tryFit(x,y,tentacle):
		
	var blockedAreas =	[]
	
	for i in range(0,Global.Game.get_node("Zones/BockedAreas").get_child_count(),1):
		blockedAreas.append(Global.Game.get_node("Zones/BockedAreas").get_child(i))
		
	blockedAreas.append(Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D"))
		
	var TryPosition = Vector2(x,y)
	
	if (!Global.areaBoxCollision(tentacle,TryPosition,tentacle.get_node("Area2D"),blockedAreas)):
		return true
	else:
		return false

func _process(delta):

	if (Global.player.playerOnCenterPoint or Global.Game.get_node("WaveController").mining):
		destroy()
	
	if (quality=="legendary"):
		$Sprite2D2.modulate.a=float(frame)/float(max_duration*60)	
	
	$Sprite2D.modulate.a=float(frame)/float(max_duration*60)
	var s = float(frame*maxWaveScale.x)/float(max_duration*60)
	$AnimatedSprite2D.scale= Vector2(s,s)
	knockBack()

	frame+=1

func destroy():
	Global.hud.max_ultimate_frame=(cd)*60
	Global.timerCreator("enableAttackUse",cd,[4],Global.player)
	Global.Game.get_node("Night").visible=false
	krakenAlly.queue_free()
	queue_free()

func knockBack():
	for i in range(0,monstersInArea.size(),1):
		var monster = monstersInArea[i]
		var monsterHitObject=monstersHit[getMonsterHitIndex(monster)]
		if (monsterHitObject.knockback>=maxKnockback):
			continue
		var angle= global_position.angle_to_point(monster.global_position)
		monstersHit[getMonsterHitIndex(monster)]={"monster":monster,"knockback":monsterHitObject.knockback+knockBackSpeed,"objectReference":weakref(monster)}
		tryToMove(knockBackSpeed*cos(angle),knockBackSpeed*sin(angle),monster)
		
		
func tryToMove(speedX,speedY,monster):

	var topSpeed = 150
	if (abs(speedX)>topSpeed):
		speedX=speedX*topSpeed/abs(speedX)
	if (abs(speedY)>topSpeed):
		speedY=speedY*topSpeed/abs(speedY)
		
	var blockedAreas =	[]
	
	for i in range(0,Global.Game.get_node("Zones/BockedAreas").get_child_count(),1):
		blockedAreas.append(Global.Game.get_node("Zones/BockedAreas").get_child(i))
		
	#blockedAreas.append(Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D"))
		
	var nextTryPosition = Vector2(monster.global_position.x+speedX,monster.global_position.y+speedY)
	if (!Global.areaBoxCollision(monster,nextTryPosition,monster.get_node("Area2D"),blockedAreas)):
		monster.global_position.y+=speedY
		monster.global_position.x+=speedX
		return true
	

func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())

		
func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("removeMonster",area.get_parent())
		

func removeMonster(monster):
	monstersInArea.erase(monster)
			
func addMonster(monster):
	monstersInArea.append(monster)
	
	if (monstersHit.is_empty() or !checkIfExist(monster.name)):
		monstersHit.append({"monster":monster,"knockback":0,"objectReference":weakref(monster)})
		monster.hp-=damage


func checkIfExist(name):
	for i in range(0,monstersHit.size(),1):
		if itsValid(monstersHit[i]):
			var monsterName= monstersHit[i].monster.name
			if (monsterName==name):
				return true
	return false

func itsValid(element):
	if (element.objectReference.get_ref()):
		return true
	return false

func getMonsterHitIndex(monster):
	for i in range(0,monstersHit.size(),1):
		if itsValid(monstersHit[i]):
			if (monstersHit[i].monster.name==monster.name):
				return i
