extends Node2D

var regenBonus=false
var lastQuality

func _process(delta):

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
			Global.player.hpRegeneration+=2
		elif ( quality=="rare"):
			Global.player.hpRegeneration+=4
		elif ( quality=="epic"):
			Global.player.hpRegeneration+=6
		elif ( quality=="legendary"):
			Global.player.hpRegeneration+=8
		elif (quality=="divine"):
			Global.player.hpRegeneration+=10


	if ((Global.player.attack2.skill!=PreLoads.warrior_attack2_hades and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_HadesPoseidon and
	Global.player.attack2.skill!=PreLoads.warrior_attack2_divine_ZeusHades) and regenBonus):
		
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
