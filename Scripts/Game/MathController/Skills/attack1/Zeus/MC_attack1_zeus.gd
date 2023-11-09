extends Node2D

var electrified=[]

func addEntityElectrified(element,extraPercentDamage):
	
	if (electrified.is_empty() or !Global.MathController.checkIfExist(element.name,electrified)):
		var el=PreLoads.eletrified.instantiate()
		element.add_child(el)
		el.global_position=element.global_position
		
		var obj= {"element":element,"objectReference":weakref(element),"frame":0,
		"maxFrame":(5*60),"extraPercentDamage":extraPercentDamage,"electrifiedAnimation":el}
		electrified.append(obj)

	else:
		var i=Global.MathController.getElementIndex(element,electrified)
		electrified[i]= {"element":electrified[i].element,"objectReference":weakref(electrified[i].element),"frame":0,
		"maxFrame":electrified[i].maxFrame,"extraPercentDamage":electrified[i].extraPercentDamage,"electrifiedAnimation":electrified[i].electrifiedAnimation}

func eletrifiedFunc():
	for i in range(0,electrified.size(),1):
		if (electrified[i].frame==electrified[i].maxFrame):
			if is_instance_valid(electrified[i].element):
				electrified[i].electrifiedAnimation.queue_free()
			Global.MathController.call_deferred("removeObj",electrified[i],electrified)
		else:
			electrified[i]= {"element":electrified[i].element,"objectReference":weakref(electrified[i].element),"frame":(electrified[i].frame+1),
		"maxFrame":electrified[i].maxFrame,"extraPercentDamage":electrified[i].extraPercentDamage,"electrifiedAnimation":electrified[i].electrifiedAnimation}


func _process(delta):
	eletrifiedFunc()

func effect(target,finalDamage):
	if(Global.MathController.checkIfExist(target.name,electrified)):
		finalDamage*=electrified[Global.MathController.getElementIndex(target,electrified)].extraPercentDamage
		
	return finalDamage
