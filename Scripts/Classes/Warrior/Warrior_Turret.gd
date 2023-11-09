extends Node2D

#Dano por frame (respeitando nextHitDelay)
var damage = 40

#Em graus
var rotationSpeed = 4

#Duracao em segundos
var cd = 0.2
var canShoot=true

var max_duration = 30

var quality="common"

var randomTurret=true

var closerEnemy

func _ready():
	animation()
	audioInstances()
	Global.timerCreator("destroy",max_duration,[],self)
	return

func audioInstances():
	var quantityOfInstances=3
	for i in range(0,$SoundController.get_child_count(),1):
		var arrow = $SoundController.get_child(i)
		var sound = arrow.get_child(0)
		for j in range(0,quantityOfInstances-1,1):
			arrow.add_child(sound.duplicate())

func _process(_delta):
	if (Global.player.playerOnCenterPoint):
		destroy()
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
	arrow.angle=$Animations/Up.rotation_degrees
	arrow.damage=damage
	$Projectiles.add_child(arrow)

func enbaleShoot():
	canShoot=true

func playsound():
	var sounds = $SoundController.get_child(0).get_children()
	for i in range(0, sounds.size(),1):
		if (!sounds[i].playing):
			sounds[i].playing=true
			return

func animation():
	for i in range(0,$Animations.get_child_count(),1):
		var child= $Animations.get_child(i)
		child.stop()
		child.visible=true
		child.frame=0


func destroy():
	call_deferred("queue_free")

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
	if ($Animations/Up.rotation_degrees<0):
		$Animations/Up.rotation_degrees=$Animations/Up.rotation_degrees+360
	if ($Animations/Up.rotation_degrees>360):
		$Animations/Up.rotation_degrees=$Animations/Up.rotation_degrees-360

	#Se a distancia angular entre os pontos for menor que a velocidade de rotacao iguala o angulo das duas e retorna
	if (abs($Animations/Up.rotation_degrees-angleToEnemy)<rotationSpeed):
		$Animations/Up.rotation_degrees=angleToEnemy
		return
	
	#Decide se o caminho mais curto eh rotacionar na direcao horaria ou anti horararia	
	var directionclockwise= getDirection(angleToEnemy)
	
	if (directionclockwise):
		$Animations/Up.rotation_degrees+=rotationSpeed
	else:
		$Animations/Up.rotation_degrees-=rotationSpeed


func getDirection(angleToEnemy):
	var distanceClockwise
	var distanceAntiClockwise
	
	if (angleToEnemy<$Animations/Up.rotation_degrees):
		distanceClockwise= 360-$Animations/Up.rotation_degrees+angleToEnemy
		distanceAntiClockwise= $Animations/Up.rotation_degrees-angleToEnemy
	else:
		distanceClockwise= angleToEnemy-$Animations/Up.rotation_degrees
		distanceAntiClockwise=360-angleToEnemy+$Animations/Up.rotation_degrees
		
	if (distanceClockwise<distanceAntiClockwise):
		return true

	return false
	
