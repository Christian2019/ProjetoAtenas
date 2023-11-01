extends Node2D


func _ready():
	Global.MathController=self
	
#Effects
var electrified=[]

func addEntityElectrified(element,extraPercentDamage):
	var obj= {"element":element,"objectReference":weakref(element),"frame":0,
		"maxFrame":(5*60),"extraPercentDamage":extraPercentDamage}
	if (electrified.is_empty() or !checkIfExist(element.name,electrified)):
		electrified.append(obj)
	else:
		electrified[getElementIndex(element,electrified)]=obj

func eletrifiedFunc():
	for i in range(0,electrified.size(),1):
		if (electrified[i].frame==electrified[i].maxFrame):
			removeObj(electrified[i],electrified)
		else:
			electrified[i]= {"element":electrified[i].element,"objectReference":weakref(electrified[i].element),"frame":(electrified[i].frame+1),
		"maxFrame":electrified[i].maxFrame,"extraPercentDamage":electrified[i].extraPercentDamage}

func _process(delta):
	eletrifiedFunc()
		

func damageController(damage,target):
	var finalDamage=damage
	if (target.name=="Player"):
		#Se o target for player recebe os bonus dos status defensivos
		spawnDamage(finalDamage,target)
	elif (target.name!="Center"):
		
	#Effects
	
	
	#Se o target for o enemy recebe os bonus dos status ofensivos
	
		spawnDamage(finalDamage,target)

	target.hp-=finalDamage

func spawnDamage(finalDamage,target):
	var labeldamage=PreLoads.labelDamage.instantiate()
	labeldamage.damage=finalDamage
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
