extends Node2D

var disorientations=[]

func addEntityDisorientation(element,disorientationSlow,disorientationDuration):
	
	if (disorientations.is_empty() or !Global.MathController.checkIfExist(element.name,disorientations)):
		var eff=PreLoads.disorientation.instantiate()
		element.add_child(eff)
		eff.global_position=element.global_position

		var oldCds= []
		
		for i in range(0,element.attackSpeedModifierVar.size(),1):   
			oldCds.append(element.attackSpeedModifierVar[i])
		
		var obj= {"element":element,"objectReference":weakref(element),"frame":0,
		"maxFrame":disorientationDuration,"OldSpeed":element.speed,"oldCds":oldCds,"disorientationAnim":eff}
		disorientations.append(obj)
		
		element.speed=element.speed*(1-disorientationSlow)
		
		for i in range(0,element.attackSpeedModifierVar.size(),1):   
			element.attackSpeedModifierVar[i]=element.attackSpeedModifierVar[i]/(1-disorientationSlow)
		

	else:
		var i=Global.MathController.getElementIndex(element,disorientations)
		disorientations[i].frame=0
		
func disorientationFunc():
	for i in range(0,disorientations.size(),1):
		if (disorientations[i].frame==disorientations[i].maxFrame):
			
			if is_instance_valid(disorientations[i].element):
				disorientations[i].disorientationAnim.queue_free()
				disorientations[i].element.speed=disorientations[i].OldSpeed
				for j in range(0,disorientations[i].element.attackSpeedModifierVar.size(),1):   
					disorientations[i].element.attackSpeedModifierVar[j]=disorientations[i].oldCds[j]
			
			Global.MathController.call_deferred("removeObj",disorientations[i],disorientations)
		else:
			disorientations[i].frame+=1

func _process(delta):
	disorientationFunc()
