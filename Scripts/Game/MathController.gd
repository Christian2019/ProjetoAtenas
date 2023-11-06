extends Node2D
###Effects

##Attack1

#Zeus

var electrified=[]

func addEntityElectrified(element,extraPercentDamage):
	
	if (electrified.is_empty() or !checkIfExist(element.name,electrified)):
		var el=PreLoads.eletrified.instantiate()
		element.add_child(el)
		el.global_position=element.global_position
		
		var obj= {"element":element,"objectReference":weakref(element),"frame":0,
		"maxFrame":(5*60),"extraPercentDamage":extraPercentDamage,"electrifiedAnimation":el}
		electrified.append(obj)

	else:
		var i=getElementIndex(element,electrified)
		electrified[i]= {"element":electrified[i].element,"objectReference":weakref(electrified[i].element),"frame":0,
		"maxFrame":electrified[i].maxFrame,"extraPercentDamage":electrified[i].extraPercentDamage,"electrifiedAnimation":electrified[i].electrifiedAnimation}

func eletrifiedFunc():
	for i in range(0,electrified.size(),1):
		if (electrified[i].frame==electrified[i].maxFrame):
			if is_instance_valid(electrified[i].element):
				electrified[i].electrifiedAnimation.queue_free()
			call_deferred("removeObj",electrified[i],electrified)
		else:
			electrified[i]= {"element":electrified[i].element,"objectReference":weakref(electrified[i].element),"frame":(electrified[i].frame+1),
		"maxFrame":electrified[i].maxFrame,"extraPercentDamage":electrified[i].extraPercentDamage,"electrifiedAnimation":electrified[i].electrifiedAnimation}

#Poseidon

var waterDamage=[]

func addEntityWaterDamage(element,extraDamagePerConsHit):
	if (waterDamage.is_empty() or !checkIfExist(element.name,waterDamage)):
		var obj= {"element":element,"objectReference":weakref(element),"ConsHit":1,
		"extraDamagePerConsHit":extraDamagePerConsHit}
		waterDamage.append(obj)

	else:
		var i=getElementIndex(element,waterDamage)
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
	if (Global.MathController.heavyDamageInstances-1==i):
		Global.MathController.heavyDamageOn=false
		Global.MathController.heavyDamageHits=0
		attackInstance.heavyDamageOn=false
	else:
		attackInstance.heavyDamageOn=true

func clearArrays():
	electrified.clear()
	waterDamage.clear()
	heavyDamageHits=0

func _ready():
	Global.MathController=self
	Global.timerCreator("printEffectsArrays",1,[],self)
	
	
func printEffectsArrays():
	return
	Global.timerCreator("printEffectsArrays",1,[],self)
	print(electrified)
	

func _process(delta):
	eletrifiedFunc()

		

func damageController(damage,target):
	var finalDamage=damage
	var crit=false
	var miss=false
	if (target.name=="Player"):
		
		#Armor
		var armor=Global.player.armor
		var armorTankMultiplier
		if (armor>=0):
			armorTankMultiplier = 1+ (armor*0.05)
		else:
			armor *=-1
			armorTankMultiplier = 1/ (1+(armor*0.05))
		
		finalDamage/=armorTankMultiplier
		
		#Dodge
		if (Global.player.dodge>0):
			var dodge
			if(Global.player.dodge>Global.player.maxDodge):
				dodge=Global.player.maxDodge
			else:
				dodge=Global.player.dodge
			
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=dodge):
				miss=true
				finalDamage=0

		spawnDamage(finalDamage,target,crit,true,miss,false)
		
	elif (target.name!="Center"):
		
		#Effects
		finalDamage=effects(target,finalDamage)

		#Stats Damage Extra
		finalDamage*=Global.player.baseDamage*Global.player.percentDamage

		#Crit
		if (Global.player.percentCritDamage>0):
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=int(Global.player.percentCritDamage*100)):
				finalDamage*=2
				crit=true
		
		#LifeStealChance
		if (Global.player.lifeStealChance>0):
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=int(Global.player.lifeStealChance*100)):
				Global.player.hp+=1
				if Global.player.hp>Global.player.maxHp:
					Global.player.hp=Global.player.maxHp
				spawnDamage(finalDamage,Global.player,crit,false,miss,true)

		spawnDamage(finalDamage,target,crit,false,miss,false)

	target.hp-=finalDamage


	
func effects(target,finalDamage):
	
	if (checkIfExist(target.name,waterDamage)):
		var wd=waterDamage[getElementIndex(target,waterDamage)]
		finalDamage+=(wd.ConsHit*wd.extraDamagePerConsHit)
		
	if(checkIfExist(target.name,electrified)):
		finalDamage*=electrified[getElementIndex(target,electrified)].extraPercentDamage
	
	
	return finalDamage

func spawnDamage(finalDamage,target,crit,colorBlue,miss,lifeSteal):
	var labeldamage=PreLoads.labelDamage.instantiate()
	labeldamage.damage=finalDamage
	labeldamage.crit=crit
	labeldamage.colorBlue=colorBlue
	labeldamage.miss=miss
	labeldamage.lifeSteal=lifeSteal
	add_child(labeldamage)
	labeldamage.global_position=target.global_position
	

func removeObj(obj,array):
	array.erase(obj)
			
func checkIfExist(name,array):
	for i in range(0,array.size(),1):
		if itsValid(array[i]):
			if (array[i].element.name==name):
				return true
	return false
	
func itsValid(element):
	if (element.objectReference.get_ref()):
		return true
	return false

func getElementIndex(element,array):
	for i in range(0,array.size(),1):
		if itsValid(array[i]):
			if (array[i].element.name==element.name):
				return i
