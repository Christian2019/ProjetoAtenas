extends Node2D


var bonus=false
var lastQuality
var quality

func _process(delta):

	if !bonus and verifyActivation():
	
		bonus=true

		lastQuality=quality

		if ( quality=="legendary"):
			Global.player.armor+=5
			Global.player.dodge+=15
			Global.player.maxDodge=80
		elif (quality=="divine"):
			Global.player.armor+=10
			Global.player.dodge+=30
			Global.player.maxDodge=80

	if bonus and !verifyActivation():

		bonus=false
		var quality=lastQuality
		
		if ( quality=="legendary"):
			Global.player.armor-=5
			Global.player.dodge-=15
			Global.player.maxDodge=70
		elif (quality=="divine"):
			Global.player.armor-=10
			Global.player.dodge-=30
			Global.player.maxDodge=70
			
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
