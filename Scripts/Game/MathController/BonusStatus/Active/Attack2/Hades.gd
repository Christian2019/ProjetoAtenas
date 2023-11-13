extends Node2D

var regenBonus=false
var lastQuality



func _process(delta):
	"""
	if ((Global.player.attack2.skill==PreLoads.warrior_attack2_poseidon or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusPoseidon or
	Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon) and !maxHpPercentBonus):
	"""
	if ((Global.player.attack2.skill==PreLoads.warrior_attack2_hades or
	Global.Game.skills[1].skill==5 or
	Global.Game.skills[1].skill==6) and !regenBonus):
	
		regenBonus=true
		
		var quality
		
				#if (Global.player.attack2.skill==PreLoads.warrior_attack2_divine_ZeusPoseidon or
	#Global.player.attack2.skill==PreLoads.warrior_attack2_divine_HadesPoseidon):
		
		if (Global.Game.skills[1].skill==5 or Global.Game.skills[1].skill==6):
			quality="divine"
		else:
			quality=Global.player.attack2.quality
		
		lastQuality=quality

		
		if ( quality=="common"):
			Global.player.hpRegeneration+=2
		elif ( quality=="rare"):
			Global.player.hpRegeneration+=4
		elif ( quality=="epic"):
			Global.player.hpRegeneration+=6
		elif ( quality=="legendary"):
			Global.player.hpRegeneration+=8
		elif (quality=="divine"):
			Global.player.hpRegeneration+=10
			

	
	#if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_poseidon and
	#Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_ZeusPoseidon and
	#Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_HadesPoseidon) and maxHpPercentBonus):
	
	if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_hades and
	Global.Game.skills[1].skill!=5 and
	Global.Game.skills[1].skill!=6) and regenBonus):
		
		regenBonus=false
		var quality=lastQuality

		
		if ( quality=="common"):
			Global.player.hpRegeneration-=2
		elif ( quality=="rare"):
			Global.player.hpRegeneration-=4
		elif ( quality=="epic"):
			Global.player.hpRegeneration-=6
		elif ( quality=="legendary"):
			Global.player.hpRegeneration-=8
		elif (quality=="divine"):
			Global.player.hpRegeneration-=10
		
