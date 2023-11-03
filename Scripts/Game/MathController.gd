extends Node2D

#Effects
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

func clearArrays():
	electrified.clear()

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

	#Effects
		if(checkIfExist(target.name,electrified)):
			finalDamage=finalDamage*electrified[getElementIndex(target,electrified)].extraPercentDamage
	
	
		spawnDamage(finalDamage,target,crit,false,miss,false)

	target.hp-=finalDamage

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
