extends Node2D


var bonus=false
var lastQuality
var quality

func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS
	if !bonus and verifyActivation():
	
		bonus=true

		lastQuality=quality

		if ( quality=="legendary"):
			Global.player.armor+=AllSkillsValues.warrior_dash_zeus_UltraInstinct.armor
			Global.player.dodge+=AllSkillsValues.warrior_dash_zeus_UltraInstinct.dodge
			Global.player.maxDodge=AllSkillsValues.warrior_dash_zeus_UltraInstinct.maxDodge
		elif (quality=="divine"):
			Global.player.armor+=AllSkillsValues.warrior_dash_divine_zeus_UltraInstinct.armor
			Global.player.dodge+=AllSkillsValues.warrior_dash_divine_zeus_UltraInstinct.dodge
			Global.player.maxDodge=AllSkillsValues.warrior_dash_divine_zeus_UltraInstinct.maxDodge

	if bonus and !verifyActivation():

		bonus=false
		var quality=lastQuality
		
		if ( quality=="legendary"):
			Global.player.armor-=AllSkillsValues.warrior_dash_zeus_UltraInstinct.armor
			Global.player.dodge-=AllSkillsValues.warrior_dash_zeus_UltraInstinct.dodge
			Global.player.maxDodge=AllSkillsValues.maxDodge
		elif (quality=="divine"):
			Global.player.armor-=AllSkillsValues.warrior_dash_divine_zeus_UltraInstinct.armor
			Global.player.dodge-=AllSkillsValues.warrior_dash_divine_zeus_UltraInstinct.dodge
			Global.player.maxDodge=AllSkillsValues.maxDodge
			
func verifyActivation():
	if (Global.player.dash.skill==PreLoads.warrior_dash_zeus and Global.player.dash.quality=="legendary"):
		quality = Global.player.dash.quality
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusPoseidon):
		quality="divine"
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusHades):
		quality="divine"
		return true
		
	return false
