extends Node2D

var direction = "E"
var relativePosition= Vector2(0,0)

var nextHitDelay = 1

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var collidinWithPlayer=false

var reverseOrder=false

var createdLightning=false

#Variaveis modificaveis pelo jogador:
var quality="legendary"

#Damages 
var damage = 10

#AttackSpeeds
var speed = 10
var max_duration = 0.5

#God var
var attackSpeedBonusDuration=5*60
var attackSpeedBonusPercent

#LegendaryExtra
var frenzyPercent=0

var divineReference

func _ready():
	attackSpeedModifier()
	Global.timerCreator("enableReverseOrder",max_duration/2,[],self)
	$Animation.visible=false
	qualityStatus()

func attackSpeedModifier():
	max_duration=max_duration/Global.player.attack_Speed
	speed=speed*Global.player.attack_Speed

func qualityStatus():
	if ( quality=="common"):
		attackSpeedBonusPercent=0.01
	elif ( quality=="rare"):
		attackSpeedBonusPercent=0.02
	elif ( quality=="epic"):
		attackSpeedBonusPercent=0.03
	elif ( quality=="legendary"):
		attackSpeedBonusPercent=0.04
		frenzyPercent=0.1
	elif ( quality=="divine"):
		attackSpeedBonusPercent=0.06
		frenzyPercent=0.2

func _process(_delta):
	animation()
	move()
	damageAction()
	destroy()

func animation():
	if ($Animation.visible):
		return
	$Animation.visible=true
	$Animation.frame=0
	if direction=="NE":
		$Animation.rotate(deg_to_rad(45))
	elif direction=="E":
		$Animation.rotate(deg_to_rad(90))
	elif direction=="SE":
		$Animation.rotate(deg_to_rad(135))
	elif direction=="S":
		$Animation.rotate(deg_to_rad(180))
	elif direction=="SW":
		$Animation.rotate(deg_to_rad(225))
	elif direction=="W":
		$Animation.rotate(deg_to_rad(270))
	elif direction=="NW":
		$Animation.rotate(deg_to_rad(315))

func enableReverseOrder():
	reverseOrder=true
	

func destroy():
	if (reverseOrder and collidinWithPlayer):
		if (quality=="divine"):
			if is_instance_valid(divineReference):
				divineReference.skillsFinish+=1
		else:
			Global.player.permissions[0]=true
		call_deferred("queue_free")

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
					Global.MathController.attack1_hades.addEntityASB(monstersHit[i].monster,attackSpeedBonusPercent,
					frenzyPercent,attackSpeedBonusDuration)
					Global.MathController.damageController(damage,monstersHit[i].monster)
			
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)


func move():
	if reverseOrder:
		var dx = (speed)*cos(get_angle_to(Global.player.global_position))
		var dy = (speed)*sin(get_angle_to(Global.player.global_position))
		relativePosition+=Vector2(dx,dy)
	else:
		var speedModifier=1
		#Corrigi a velocidade na diagonal
		if direction=="NE" or direction=="NW" or direction=="SE" or direction=="SW":
			speedModifier=1/(2**0.5)			
		
		#Y+
		if direction=="SE" or direction=="S" or direction=="SW":
			relativePosition.y+=(speed)*speedModifier
		#Y-
		if direction=="NE" or direction=="N" or direction=="NW":
			relativePosition.y-=(speed)*speedModifier
		
		#X+
		if direction=="SE" or direction=="E" or direction=="NE":
			relativePosition.x+=(speed)*speedModifier
		
		#X-
		if direction=="SW" or direction=="W" or direction=="NW":
			relativePosition.x-=(speed)*speedModifier
		
	global_position= Global.player.global_position+relativePosition
		
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
	