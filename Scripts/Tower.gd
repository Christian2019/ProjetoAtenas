extends Node2D

var reloadTime = 5
var allowToShoot = true
var minDistance = 261

func _process(delta):
	if (allowToShoot):
		lookEnemies()

func lookEnemies():
	var closerEnemy
	var enemies = get_parent().get_parent().get_node("Enemies").get_children()
	for i in range(0,enemies.size(),1):
		var enemy = enemies[i]
		if (!positionConditionAllow(enemy)):
			continue
		shoot(enemy)
		break	
	
func shoot(enemy):
	allowToShoot=false
	Global.timerCreator("setAllowToShoot",reloadTime,[true],self)
	var arrow = PreLoadeds.tower_projectile.instantiate()
	arrow.position = position
	arrow.position.x+=28
	arrow.target=enemy
	get_parent().get_parent().get_node("Projectiles").add_child(arrow)
	
	
func setAllowToShoot(b):
	allowToShoot=b	
		
func positionConditionAllow(enemy):
	if (position.distance_to(enemy.position)>minDistance):
		return false
	
	#Especifica qual estrada a torre faz parte oeste,norte ou leste
	var westLimitX = 1022 
	var eastLimitX = 1535
	
	#Oeste
	if (position.x<westLimitX):
		if (enemy.position.x>westLimitX):
			return false
	
	#Leste	
	elif (position.x>eastLimitX):
		if (enemy.position.x<eastLimitX):
			return false
			
	#Norte	
	else:
		if (enemy.position.x<westLimitX or position.x>eastLimitX):
			return false
	
	return true
