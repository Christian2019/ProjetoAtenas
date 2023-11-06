extends Node2D

var attackSpeedBonusArray=[]
var twister_effect

func _ready():
	var twister = PreLoads.twister.instantiate()
	Global.player.add_child(twister)
	twister.global_position=Global.player.global_position
	twister.get_node("AnimatedSprite2D").visible=true
	twister.modulate.a=0.5
	twister_effect=twister

		


func addEntityASB(element,asb,frenzy,maxDuration):
	
	if (attackSpeedBonusArray.is_empty() or !Global.MathController.checkIfExist(element.name,attackSpeedBonusArray)):
		var lifestealAdded=frenzy*Global.player.attack_Speed
		var obj= {"element":element,"objectReference":weakref(element),"frame":0,
		"maxFrame":maxDuration,"attackSpeedBonus":asb, "frenzy":frenzy, "lifeStealAdded":lifestealAdded}
		attackSpeedBonusArray.append(obj)
		
		Global.player.attack_Speed+=asb
		Global.player.lifeStealChance+=lifestealAdded

	else:
		var i=Global.MathController.getElementIndex(element,attackSpeedBonusArray)
		attackSpeedBonusArray[i].frame=0
		
func ASBFunc():
	for i in range(0,attackSpeedBonusArray.size(),1):
		if (attackSpeedBonusArray[i].frame==attackSpeedBonusArray[i].maxFrame):
			Global.player.attack_Speed-=attackSpeedBonusArray[i].attackSpeedBonus
			Global.player.lifeStealChance-=attackSpeedBonusArray[i].lifeStealAdded
			Global.MathController.call_deferred("removeObj",attackSpeedBonusArray[i],attackSpeedBonusArray)
		else:
			attackSpeedBonusArray[i].frame+=1

func _process(delta):
	ASBFunc()
	if (attackSpeedBonusArray.is_empty() and twister_effect.get_node("AnimatedSprite2D").visible):
		twister_effect.get_node("AnimatedSprite2D").visible=false
	if (!attackSpeedBonusArray.is_empty() and !twister_effect.get_node("AnimatedSprite2D").visible):
		twister_effect.get_node("AnimatedSprite2D").visible=true
