extends Node2D

var waterDamage=[]

func addEntityWaterDamage(element,extraDamagePerConsHit):
	if (waterDamage.is_empty() or !Global.MathController.checkIfExist(element.name,waterDamage)):
		var obj= {"element":element,"objectReference":weakref(element),"ConsHit":1,
		"extraDamagePerConsHit":extraDamagePerConsHit}
		waterDamage.append(obj)

	else:
		var i=Global.MathController.getElementIndex(element,waterDamage)
		waterDamage[i].ConsHit+=1

var heavyDamageHits=0
var heavyDamageMaxHits=20
var heavyDamageOn=false
var heavyDamageInstances=0

func heavyDamageInstance(i):
	var attackInstance = Global.player.creatAttackInstance(0)
	Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
	attackInstance.global_position=Global.player.global_position
	attackInstance.direction=Global.player.lastMovement
	if (heavyDamageInstances-1==i):
		heavyDamageOn=false
		heavyDamageHits=0
		attackInstance.heavyDamageOn=false
	else:
		attackInstance.heavyDamageOn=true

func effect(target,finalDamage):
	if (Global.MathController.checkIfExist(target.name,waterDamage)):
		var wd=waterDamage[Global.MathController.getElementIndex(target,waterDamage)]
		finalDamage+=(wd.ConsHit*wd.extraDamagePerConsHit)

	return finalDamage
	
func heavyDamageActivation():
	heavyDamageOn=true
	var heavyDamageInterval=0.05
	heavyDamageInstance(0)
	var hd= PreLoads.warrior_attack1_poseidon_heavyDamage.instantiate()
	Global.Game.get_node("Instances/Explosions").add_child(hd)
	hd.global_position=global_position
	
	for i in range(1,heavyDamageInstances,1):
		Global.timerCreator("heavyDamageInstance",(heavyDamageInterval*i),[i],self)
