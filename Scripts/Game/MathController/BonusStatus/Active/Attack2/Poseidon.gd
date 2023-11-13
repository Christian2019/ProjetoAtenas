extends Node2D

var maxHpPercentBonus=false
var lastQuality


func _process(delta):

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
			Global.player.maxHpPercentBonus+=0.03
		elif ( quality=="rare"):
			Global.player.maxHpPercentBonus+=0.06
		elif ( quality=="epic"):
			Global.player.maxHpPercentBonus+=0.12
		elif ( quality=="legendary"):
			Global.player.maxHpPercentBonus+=0.24
		elif (quality=="divine"):
			Global.player.maxHpPercentBonus+=0.48
			

	
	if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_poseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_ZeusPoseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_HadesPoseidon) and maxHpPercentBonus):

		maxHpPercentBonus=false
		var quality=lastQuality
		
		if ( quality=="common"):
			Global.player.maxHpPercentBonus-=0.03
		elif ( quality=="rare"):
			Global.player.maxHpPercentBonus-=0.06
		elif ( quality=="epic"):
			Global.player.maxHpPercentBonus-=0.12
		elif ( quality=="legendary"):
			Global.player.maxHpPercentBonus-=0.24
		elif (quality=="divine"):
			Global.player.maxHpPercentBonus-=0.48
		
