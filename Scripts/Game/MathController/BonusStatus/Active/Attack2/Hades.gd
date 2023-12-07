extends Node2D

var regenBonus=false
var lastQuality

func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS
	if ((Global.player.attack2.skill==PreLoads.warrior_attack2_hades or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusHades) and !regenBonus):
	
		regenBonus=true
		
		var quality
		
		if (Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon or
		Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusHades):
			quality="divine"
		else:
			quality=Global.player.attack2.quality
		
		lastQuality=quality

		if ( quality=="common"):
			Global.player.hpRegeneration+=AllSkillsValues.warrior_attack2_hades_hpRengen[0]
		elif ( quality=="rare"):
			Global.player.hpRegeneration+=AllSkillsValues.warrior_attack2_hades_hpRengen[1]
		elif ( quality=="epic"):
			Global.player.hpRegeneration+=AllSkillsValues.warrior_attack2_hades_hpRengen[2]
		elif ( quality=="legendary"):
			Global.player.hpRegeneration+=AllSkillsValues.warrior_attack2_hades_hpRengen[3]
		elif (quality=="divine"):
			Global.player.hpRegeneration+=AllSkillsValues.warrior_attack2_divine_hades_hpRengen


	if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_hades and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_HadesPoseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_ZeusHades) and regenBonus):
		
		regenBonus=false
		var quality=lastQuality

		if ( quality=="common"):
			Global.player.hpRegeneration-=AllSkillsValues.warrior_attack2_hades_hpRengen[0]
		elif ( quality=="rare"):
			Global.player.hpRegeneration-=AllSkillsValues.warrior_attack2_hades_hpRengen[1]
		elif ( quality=="epic"):
			Global.player.hpRegeneration-=AllSkillsValues.warrior_attack2_hades_hpRengen[2]
		elif ( quality=="legendary"):
			Global.player.hpRegeneration-=AllSkillsValues.warrior_attack2_hades_hpRengen[3]
		elif (quality=="divine"):
			Global.player.hpRegeneration-=AllSkillsValues.warrior_attack2_divine_hades_hpRengen
