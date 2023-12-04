extends Node2D

var maxTurrets

func _process(delta):
	checkQuality()
	if (get_child_count()>maxTurrets):
		get_child(0).call_deferred("destroy")

func checkQuality():
	var quality
	if (Global.player.turret.skill==PreLoads.warrior_turret_divine_HadesPoseidon or
	Global.player.turret.skill==PreLoads.warrior_turret_divine_ZeusHades or
	Global.player.turret.skill==PreLoads.warrior_turret_divine_ZeusPoseidon):
		quality="divine"
	else:
		quality= Global.player.turret.quality

	if ( quality=="common"):
		maxTurrets=AllSkillsValues.turretsQuantity[0]
	elif ( quality=="rare"):
		maxTurrets=AllSkillsValues.turretsQuantity[1]
	elif ( quality=="epic"):
		maxTurrets=AllSkillsValues.turretsQuantity[2]
	elif ( quality=="legendary"):
		maxTurrets=AllSkillsValues.turretsQuantity[3]
	elif (quality=="divine"):
		maxTurrets=AllSkillsValues.turretsQuantity[4]
