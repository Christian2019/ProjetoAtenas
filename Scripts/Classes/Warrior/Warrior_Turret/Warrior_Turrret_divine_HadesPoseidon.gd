extends Node2D

#Em graus
var rotationSpeed = 4

#Duracao em segundos
var cd = 0.5
var canShoot=true

var max_duration = 20

var quality

var closerEnemy

var angle=0.0

#GodBonus
var damage
var acumulatedDamage=0
var area=1

var pierce=0
var waterDamage=0

var nextHitDelay = 1

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var lastFrame=0

func _ready():
	Global.timerCreator("destroy",max_duration,[],self)
	attackSpeedModifier()
	attackSpeedModifier()
	$AnimatedSprite2D/AnimatedSprite2D2.modulate.a=0.5
	qualityStatus()

func attackSpeedModifier():
	cd=cd/Global.player.attack_Speed

func qualityStatus():
		damage=AllSkillsValues.warrior_turret_divine_poseidon_sd+AllSkillsValues.warrior_turret_divine_hades_damage
		area=AllSkillsValues.warrior_turret_divine_hades_area
		pierce=AllSkillsValues.warrior_turret_divine_poseidon_pierce
		waterDamage=AllSkillsValues.warrior_turret_divine_poseidon_waterDamage
		
func destroy():
	createExplosion()
	call_deferred("queue_free")

func createExplosion():
	var e=PreLoads.warrior_turret_hades_explosion.instantiate()
	e.damage=acumulatedDamage
	e.area=area
	Global.Game.get_node("Instances/Projectiles").add_child(e)
	e.global_position=global_position

func _process(_delta):
	if (Global.player.playerOnCenterPoint):
		destroy()
	var enemies = Global.Game.get_node("Enemies").get_children()
	if enemies.size() == 0:
		return
	getCloserEnemy(enemies)
	move()
	damageAction()
	shoot()

func getCloserEnemy(enemies):
	closerEnemy=enemies[0]
	for i in range(0,enemies.size(),1):
		var enemy = enemies[i]
		if (global_position.distance_to(enemy.global_position)<global_position.distance_to(closerEnemy.global_position)):
			closerEnemy=enemy

func move():
	#Pega o angulo entre a turret e inimigo e normaliza entre 0 e 360
	var angleToEnemy = rad_to_deg(global_position.angle_to_point(closerEnemy.global_position))
	
	if (angleToEnemy<0):
		angleToEnemy=angleToEnemy+360

	#Normaliza o angulo da animacao entre 0 e 360
	if (angle<0):
		angle+=360
	if (angle>360):
		angle-=360


	#Decide se o caminho mais curto eh rotacionar na direcao horaria ou anti horararia	
	if (directionClockwise(angleToEnemy)):
		angle+=rotationSpeed
	else:
		angle-=rotationSpeed
	
	#Se a distancia angular entre os pontos for menor que a velocidade de rotacao iguala o angulo das duas e retorna
	if (abs(angle-angleToEnemy)<rotationSpeed):
		angle=angleToEnemy
	
	animation()

func directionClockwise(angleToEnemy):
	var distanceClockwise
	var distanceAntiClockwise
	
	if (angleToEnemy<angle):
		distanceClockwise= 360-angle+angleToEnemy
		distanceAntiClockwise= angle-angleToEnemy
	else:
		distanceClockwise= angleToEnemy-angle
		distanceAntiClockwise=360-angleToEnemy+angle
		
	if (distanceClockwise<distanceAntiClockwise):
		return true

	return false

func animation():
	var distance = abs(angle-360)
	var frame=0
	
	for i in range(0,16,1):
		if abs(angle-(float(i)*22.5))<distance:
			distance=abs(angle-(float(i)*22.5))
			frame=i
	
	$AnimatedSprite2D.frame=frame
	$Area2D.rotation_degrees=float(frame)*22.5
	if (lastFrame!=frame):
		lastFrame=frame
		$AnimatedSprite2D/AnimatedSprite2D2.play(str(float(frame)*22.5))
	


func removeNextHitDelay(arrayPosition):
	if (itsValid(monstersHit[arrayPosition])):
		monstersHit[arrayPosition].onHitDelay=false
	
func damageAction():
	if (monstersInArea.is_empty()):
		return
	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					Global.MathController.damageController(damage,monstersHit[i].monster)
					acumulatedDamage+=damage
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

func shoot():
	if !canShoot:
		return
	canShoot=false
	Global.timerCreator("enbaleShoot",cd,[],self)
	var arrow = PreLoads.warrior_turret_poseidon_arrow.instantiate()
	arrow.angle=angle
	arrow.damage=damage
	arrow.pierce=pierce
	arrow.waterDamage=waterDamage
	Global.Game.get_node("Instances/Projectiles").add_child(arrow)
	arrow.global_position=global_position

func enbaleShoot():
	canShoot=true
		
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
		monstersHit.append({"monster":monster,"onHitDelay":false,"objectReference":weakref(monster)})


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
