extends Node2D

#Dano por frame (respeitando nextHitDelay)
var damage = 0.1

#Em graus
var rotationSpeed = 4

#Duracao em segundos
var cd = 0.2
var canShoot=true

var max_duration = 30

var attacktype=0

var closerEnemy

func _ready():
	animation()
	audioInstances()
	Global.timerCreator("destroy",max_duration,[],self)
	return

func audioInstances():
	var quantityOfInstances=5
	for i in range(0,$SoundController.get_child_count(),1):
		var arrow = $SoundController.get_child(i)
		var sound = arrow.get_child(0)
		for j in range(0,quantityOfInstances-1,1):
			arrow.add_child(sound.duplicate())

func _process(_delta):
	var enemies = Global.Game.get_node("Enemies").get_children()
	if enemies.size() == 0:
		return
	getCloserEnemy(enemies)
	move()
	shoot()

func shoot():
	if !canShoot:
		return
	canShoot=false
	Global.timerCreator("enbaleShoot",cd,[],self)
	playsound()
	var arrow = PreLoads.warrior_arrow.instantiate()
	arrow.attacktype=attacktype
	arrow.angle=$Animations/Up.rotation_degrees
	arrow.damage=damage
	$Projectiles.add_child(arrow)

func enbaleShoot():
	canShoot=true

func playsound():
	var sounds = $SoundController.get_child(attacktype).get_children()
	for i in range(0, sounds.size(),1):
		if (!sounds[i].playing):
			sounds[i].playing=true
			return

func animation():
	for i in range(0,$Animations.get_child_count(),1):
		var child= $Animations.get_child(i)
		child.stop()
		child.visible=true
		child.frame=attacktype


func destroy():
	call_deferred("queue_free")

func getCloserEnemy(enemies):
	closerEnemy=enemies[0]
	for i in range(0,enemies.size(),1):
		var enemy = enemies[i]
		if (global_position.distance_to(enemy.global_position)<global_position.distance_to(closerEnemy.global_position)):
			closerEnemy=enemy
	

func move():
	var angleToEnemy = rad_to_deg(global_position.angle_to_point(closerEnemy.global_position))
	
	if (angleToEnemy!=$Animations/Up.rotation_degrees):
		if angleToEnemy>$Animations/Up.rotation_degrees:
			$Animations/Up.rotation_degrees+=rotationSpeed
			if angleToEnemy<$Animations/Up.rotation_degrees:
				$Animations/Up.rotation_degrees=angleToEnemy
		else:
			$Animations/Up.rotation_degrees-=rotationSpeed
			if angleToEnemy>$Animations/Up.rotation_degrees:
				$Animations/Up.rotation_degrees=angleToEnemy
	
	
"""
func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())
	if area.get_parent().name == "Player":
		collidinWithPlayer=true
		
func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("removeMonster",area.get_parent())
	if area.get_parent().name == "Player":
		collidinWithPlayer=false

func removeMonster(monster):
	monstersInArea.erase(monster)
			
func addMonster(monster):
	monstersInArea.append(monster)
	
	if (monstersHit.is_empty()):
		monstersHit.append({"monster":monster,"onHitDelay":false,"objectReference":weakref(monster)})
	elif !checkIfExist(monster.name):
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
	
"""
