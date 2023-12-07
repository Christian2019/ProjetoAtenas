extends Node2D

var maxHpPercentBonus=false
var lastQuality


func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS
	if ((Global.player.attack2.skill==PreLoads.warrior_attack2_poseidon or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusPoseidon or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon) and !maxHpPercentBonus):
	
		maxHpPercentBonus=true
		
		var quality
		
		if (Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusPoseidon or Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon):
			quality="divine"
		else:
			quality=Global.player.attack2.quality
		
		lastQuality=quality
	
		
		if ( quality=="common"):
			Global.player.maxHpPercentBonus+=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[0]
		elif ( quality=="rare"):
			Global.player.maxHpPercentBonus+=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[1]
		elif ( quality=="epic"):
			Global.player.maxHpPercentBonus+=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[2]
		elif ( quality=="legendary"):
			Global.player.maxHpPercentBonus+=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[3]
		elif (quality=="divine"):
			Global.player.maxHpPercentBonus+=AllSkillsValues.warrior_attack2_divine_poseidon_maxHpPercentBonus
			

	
	if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_poseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_ZeusPoseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_HadesPoseidon) and maxHpPercentBonus):

		maxHpPercentBonus=false
		var quality=lastQuality
		
		if ( quality=="common"):
			Global.player.maxHpPercentBonus-=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[0]
		elif ( quality=="rare"):
			Global.player.maxHpPercentBonus-=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[1]
		elif ( quality=="epic"):
			Global.player.maxHpPercentBonus-=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[2]
		elif ( quality=="legendary"):
			Global.player.maxHpPercentBonus-=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus[3]
		elif (quality=="divine"):
			Global.player.maxHpPercentBonus-=AllSkillsValues.warrior_attack2_divine_poseidon_maxHpPercentBonus
		
