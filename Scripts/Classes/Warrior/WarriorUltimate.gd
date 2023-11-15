extends Node2D

var quality="common"

#Dano por frame (respeitando nextHitDelay)
var damage
var enableDamage=false
#Duracao em segundos
var cd = 30
var cdRed=0

#var nextHitDelay = 10
var nextHitDelay = 0.2

var frame=0
var max_duration = 15
#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

func _ready():
	$Sprite2D.modulate.a=0
	Global.timerCreator("destroy", max_duration,[],self)
	Global.Game.get_node("Night").visible=true
	qualityStatus()

func qualityStatus():
	if ( quality=="common"):
		damage=200
	elif ( quality=="rare"):
		damage=300
	elif ( quality=="epic"):
		damage=400
	elif ( quality=="legendary"):
		damage=600
	elif ( quality=="divine"):
		damage=900

func destroy():
	Global.hud.max_ultimate_frame=(cd-cdRed)*60
	Global.timerCreator("enableAttackUse",cd-cdRed,[4],Global.player)
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
		cdRed=float(Global.MathController.attack1_zeus.electrified.size())*1
	if quality=="divine":
		cdRed=float(Global.MathController.attack1_zeus.electrified.size())*2	

	if (cdRed>=cd):
			cdRed=cd-0.1

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
