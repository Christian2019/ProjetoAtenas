extends Node2D

var enableSoulSteal=false

var array=[]

var positions=[]

func addSoulStealMark(element):
	
	if (array.is_empty() or !Global.MathController.checkIfExist(element.name,array)):
		var eff=PreLoads.warrior_attack2_hades_soulStealMark.instantiate()
		element.add_child(eff)
		eff.global_position=element.global_position
		
		var obj= {"element":element,"objectReference":weakref(element),"lastPosition":element.global_position}
		array.append(obj)
	

func soulStealFunc():
	
	for i in range(0,array.size(),1):
		if !is_instance_valid(array[i].element):
			positions.append(array[i].lastPosition)
			Global.MathController.call_deferred("removeObj",array[i],array)
		else:
			array[i].lastPosition=array[i].element.global_position
	
	if positions.size()>=20:
	
		Global.SoundController.playSound(Global.SoundController.soulSteal)
		var maxHpGain=AllSkillsValues.warrior_attack2_hades_soulStealCursNaxHpGain
		for i in range(0,positions.size(),1):
			var s=PreLoads.warrior_attack2_hades_soul.instantiate()
			s.maxHP=maxHpGain/positions.size()
			add_child(s)
			s.global_position=positions[i]
		positions.clear()	
		
		
func _process(delta):
	soulStealFunc()
