extends Node2D


var bonus=false
var lastQuality


func _process(delta):

	if ((Global.player.dash.skill==PreLoads.warrior_dash_zeus and 
	Global.player.dash.quality=="legendary") and !bonus):
	
		bonus=true

		var quality="legendary"
		
		
		lastQuality=quality

		if ( quality=="legendary"):
			Global.player.armor+=5
			Global.player.dodge+=15
			Global.player.maxDodge=80
		elif (quality=="divine"):
			Global.player.armor+=10
			Global.player.dodge+=30
			Global.player.maxDodge=80
			

	
	if (!(Global.player.dash.skill==PreLoads.warrior_dash_zeus and Global.player.dash.quality=="legendary")
	and bonus):

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
		
