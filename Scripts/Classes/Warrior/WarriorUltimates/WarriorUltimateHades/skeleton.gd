extends Node2D

var damage=5
var heal=10

var duration=15

var speed = 5

var target

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var nextHitDelayPlayer=false
var nextHitDelayCenterPoint=false
var nextHitDelay = 1

var cerberus=null

func _ready():
	$AnimatedSprite2D.play("Walking")
	Global.timerCreator("die",duration,[],self)
	attackSpeedModifier()

func attackSpeedModifier():
	nextHitDelay=nextHitDelay/Global.player.attack_Speed

func _process(_delta):

	getCloserTarget()
	
	if (monstersInArea.is_empty()):
		move()
	else:
		attack()


func attack():
	if ($AnimatedSprite2D.animation!= "Attacking"):
		$AnimatedSprite2D.animation= "Attacking"

	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					Global.MathController.damageController(damage,monstersHit[i].monster)
					Global.player.hp+=heal
					if (cerberus!=null):
						cerberus.totalHeal+=heal
					if (Global.player.hp>Global.player.maxHp):
						Global.player.hp=Global.player.maxHp
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

func getCloserTarget():
	var enemies = Global.Game.get_node("Enemies").get_children()
	if enemies.size() == 0:
		target=Global.player
		return
	
	var closerEnemy=enemies[0]
	for i in range(0,enemies.size(),1):
		var enemy = enemies[i]
		if (global_position.distance_to(enemy.global_position)<global_position.distance_to(closerEnemy.global_position)):
			closerEnemy=enemy
			
	target=closerEnemy

func die():
	#Animacao de morte
	call_deferred("queue_free")

func move():
	if ($AnimatedSprite2D.animation== "Attacking" and $AnimatedSprite2D.frame!=$AnimatedSprite2D.sprite_frames.get_frame_count("Attacking")-1):
		attack()
		return
	
	if ($AnimatedSprite2D.animation!= "Walking"):
		$AnimatedSprite2D.animation= "Walking"

	var targetPointX= target.position.x
	var targetPointY= target.position.y
	var distanceXtotTarget = position.x-targetPointX
	var distanceYtoTarget = position.y-targetPointY
	
	var absoluteTotalValue = abs(distanceYtoTarget)+abs(distanceXtotTarget)
	
	var speedXModifier = speed*(distanceXtotTarget/absoluteTotalValue)
	var speedYModifier = speed*(distanceYtoTarget/absoluteTotalValue)

	position.x -= speedXModifier
	position.y -= speedYModifier
	
	if (distanceXtotTarget<0):
		$AnimatedSprite2D.flip_h=true
	else:
		$AnimatedSprite2D.flip_h=false



func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())

		
func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("removeMonster",area.get_parent())
		
##Next Hit Delay Function

func enableHit(nextHitDelayTarget):
	if nextHitDelayTarget==0:
		nextHitDelayPlayer=false
	else:
		nextHitDelayCenterPoint=false


func removeNextHitDelay(arrayPosition):
	if (itsValid(monstersHit[arrayPosition])):
		monstersHit[arrayPosition].onHitDelay=false

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
