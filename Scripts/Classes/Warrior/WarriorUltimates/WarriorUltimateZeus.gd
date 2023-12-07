extends Node2D

var quality="common"

#Dano por frame (respeitando nextHitDelay)
var damage
var enableDamage=false
#Duracao em segundos
var cd
var cdRed=0

var nextHitDelay = 0.2

var frame=0
var max_duration = 15
#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var divineReference

func _ready():
	cd=AllSkillsValues.warrior_ultimate_zeus_cd
	$Sprite2D.modulate.a=0
	Global.timerCreator("destroy", max_duration,[],self)
	Global.Game.get_node("Night").visible=true
	qualityStatus()
	attackSpeedModifier()

func attackSpeedModifier():
	nextHitDelay=nextHitDelay/Global.player.attack_Speed

func qualityStatus():
	if ( quality=="common"):
		damage=AllSkillsValues.warrior_ultimate_zeus_damage[0]
	elif ( quality=="rare"):
		damage=AllSkillsValues.warrior_ultimate_zeus_damage[1]
	elif ( quality=="epic"):
		damage=AllSkillsValues.warrior_ultimate_zeus_damage[2]
	elif ( quality=="legendary"):
		damage=AllSkillsValues.warrior_ultimate_zeus_damage[3]
	elif ( quality=="divine"):
		damage=AllSkillsValues.warrior_ultimate_divine_zeus_damage

func destroy():
	if (quality=="divine"):
		if is_instance_valid(divineReference):
			divineReference.skillsFinish+=1
		if (cdRed>=divineReference.cd):
			divineReference.cd=0.01
		else:
			divineReference.cd-=cdRed
	else:
		if (cdRed>=cd):
			cd=0.01
		else:
			cd-=cdRed
		Global.hud.max_ultimate_frame=(cd)*60
		Global.timerCreator("enableAttackUse",cd,[4],Global.player)
		Global.Game.get_node("Night").visible=false
	
	queue_free()

func _process(delta):

	if (Global.player.playerOnCenterPoint or Global.Game.get_node("WaveController").mining):
		destroy()
	extraBonus()
	global_position=Global.player.global_position
	$Sprite2D.modulate.a=float(frame)/float(max_duration*60)
	damageAction()
	frame+=1

func extraBonus():
	if quality=="legendary":
		cdRed=float(Global.MathController.attack1_zeus.electrified.size())*AllSkillsValues.warrior_ultimate_zeus_cdReduction
	if quality=="divine":
		cdRed=float(Global.MathController.attack1_zeus.electrified.size())*AllSkillsValues.warrior_ultimate_divine_zeus_cdReduction	


func damageAction():
	if (monstersInArea.is_empty()):
		return
	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					createExplosion(monstersHit[i].monster)
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

func createExplosion(t):
	var e=PreLoads.warrior_attack2_poseidon_explosion.instantiate()
	e.damage=damage
	Global.Game.get_node("Instances/Projectiles").add_child(e)
	e.global_position=t.global_position

func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())

		
func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("removeMonster",area.get_parent())

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
