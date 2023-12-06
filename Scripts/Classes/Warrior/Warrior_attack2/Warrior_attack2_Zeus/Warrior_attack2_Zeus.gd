extends Node2D

var relativePosition= Vector2(0,0)

var startDistanceFromPlayer = 50

#Dano por frame (respeitando nextHitDelay)
var damage = 10

#->Graus por frame
var speed = 10

#Duracao em segundos
var max_duration = 1
#var nextHitDelay = 10
var nextHitDelay = 1

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var collidinWithPlayer=false

var reverseOrder=false

var quality="common"

var startRotationAngle

var angle

var animation

##God Status

var lightningBoltDamage 

var disorientation

var disorientationDuration=10*60

var divineReference

func _ready():
	
	startRotationAngle=90
	angle= startRotationAngle
	relativePosition.x=startDistanceFromPlayer
	global_position= Global.player.global_position+relativePosition
	qualityStatus()
	createAnimation()
	attackSpeedModifier()

func qualityStatus():
	if ( quality=="common"):
		lightningBoltDamage=AllSkillsValues.warrior_attack2_zeus_lightningBoltDamage[0]
	elif ( quality=="rare"):
		lightningBoltDamage=AllSkillsValues.warrior_attack2_zeus_lightningBoltDamage[1]
	elif ( quality=="epic"):
		lightningBoltDamage=AllSkillsValues.warrior_attack2_zeus_lightningBoltDamage[2]
	elif ( quality=="legendary"):
		lightningBoltDamage=AllSkillsValues.warrior_attack2_zeus_lightningBoltDamage[3]
		disorientation=AllSkillsValues.warrior_attack2_zeus_disorientation
	elif ( quality=="divine"):
		lightningBoltDamage=AllSkillsValues.warrior_attack2_divine_zeus_lightningBoltDamage
		disorientation=AllSkillsValues.warrior_attack2_divine_zeus_disorientation
	
func createAnimation():
	var anim = PreLoads.warrior_attack2_animations_effect.instantiate()
	Global.player.add_child(anim)
	anim.global_position=Global.player.global_position
	animation=anim
	
	
func attackSpeedModifier():
	max_duration = max_duration/Global.player.attack_Speed
	speed=360.0/(max_duration*60)


func _process(_delta):
	animationUpdate()
	move()
	damageAction()
	
func animationUpdate():
	var lastMovement= Global.player.lastMovement
	var animName="Zeus"
	
	if lastMovement=="S":
		animation.play(animName+"_Down")
	elif lastMovement=="SE":
		animation.play(animName+"_Down_Right")
	elif lastMovement=="SW":
		animation.play(animName+"_Down_Left")
	elif lastMovement=="N":
		animation.play(animName+"_Up")
	elif lastMovement=="NE":
		animation.play(animName+"_Up_Right")
	elif lastMovement=="NW":
		animation.play(animName+"_Up_Left")
	elif lastMovement=="E":
		animation.play(animName+"_Right")
	elif lastMovement=="W":
		animation.play(animName+"_Left")
"""
func animation():
	if ($Animation.visible):
		return
	$Animation.stop()
	$Animation.visible=true
	$Animation.frame=0

	$Animation.rotate(deg_to_rad(90))
	startRotationAngle=rad_to_deg($Animation.rotation)
	$Animation.flip_v=true
	angle= startRotationAngle
	
	relativePosition.x=startDistanceFromPlayer
	global_position= Global.player.global_position+relativePosition
"""

func destroy():
	
	if (quality=="divine"):
		if is_instance_valid(divineReference):
			divineReference.skillsFinish+=1
	else:
		Global.player.permissions[1]=true
			
	animation.call_deferred("queue_free")
	call_deferred("queue_free")

func damageAction():
	Global.MathController.attack1_poseidon.heavyDamageVerification()
	
	if (monstersInArea.is_empty()):
		return
	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					if (quality=="legendary" or quality=="divine"):
						Global.MathController.attack2_zeus.addEntityDisorientation(monstersHit[i].monster,disorientation,disorientationDuration)
					Global.MathController.damageController(damage,monstersHit[i].monster)
					createLightningBolt(monstersHit[i].monster)
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

func createLightningBolt(t):
	var lb=PreLoads.lightingBolt.instantiate()
	lb.damage=lightningBoltDamage
	lb.target=t
	Global.Game.get_node("Instances/Projectiles").add_child(lb)



func move():
	angle+=speed
	relativePosition.y=startDistanceFromPlayer*cos(deg_to_rad(angle))
	relativePosition.x=startDistanceFromPlayer*sin(deg_to_rad(angle))
	global_position= Global.player.global_position+relativePosition
	
	if (angle>=startRotationAngle+360):
		destroy()
		
	
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
