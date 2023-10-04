extends Node2D

var attacktype=0

#Dano por frame (respeitando nextHitDelay)
var damage = 1
var enableDamage=false
#Duracao em segundos
var cd = 20
var max_duration = 0.5
#var nextHitDelay = 10
var nextHitDelay = 0.01

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

func _ready():
	Global.Game.get_node("SoundController").enableDisableSound()
	Global.timerCreator("pauseZeusVideo",10,[],self)
	$VideoStreamPlayer.modulate.a=0
	Global.timerCreator("destroy",14,[],self)
	Global.hud.max_ultimate_frame=(14+cd)*60

func pauseZeusVideo():
	$VideoStreamPlayer.paused=true

func destroy():
	Global.timerCreator("enableAttackUse",cd,[4],Global.player)
	Global.Game.get_node("SoundController").enableDisableSound()
	Global.Game.get_node("Night").visible=false
	queue_free()

func _process(delta):
	$VideoStreamPlayer.modulate.a+=0.005
	damageAction()

func damageAction():
	if (monstersInArea.is_empty()):
		return
	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					monstersHit[i].monster.hp-=damage
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

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
