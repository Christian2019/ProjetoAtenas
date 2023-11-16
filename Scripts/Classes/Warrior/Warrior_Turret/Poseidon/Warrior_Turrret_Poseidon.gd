extends Node2D


#Em graus
var rotationSpeed = 4

#Duracao em segundos
var cd = 0.5
var canShoot=true

var max_duration = 30

var quality

var closerEnemy

var angle=0.0

#GodBonus
var damage
var pierce=0
var waterDamage=0


func _ready():
	Global.timerCreator("destroy",max_duration,[],self)
	attackSpeedModifier()
	attackSpeedModifier()
	qualityStatus()

func attackSpeedModifier():
	cd=cd/Global.player.attack_Speed

func qualityStatus():
	if ( quality=="common"):
		damage=2
	elif ( quality=="rare"):
		damage=4
		pierce=1
	elif ( quality=="epic"):
		damage=8
		pierce=2
	elif ( quality=="legendary"):
		damage=10
		pierce=3
		waterDamage=1
	elif ( quality=="divine"):
		damage=20
		pierce=4
		waterDamage=2
		
func destroy():
	call_deferred("queue_free")

func _process(_delta):
	if (Global.player.playerOnCenterPoint):
		destroy()
	var enemies = Global.Game.get_node("Enemies").get_children()
	if enemies.size() == 0:
		return
	getCloserEnemy(enemies)
	move()
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
