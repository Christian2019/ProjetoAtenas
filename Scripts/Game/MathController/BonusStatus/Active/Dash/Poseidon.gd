extends Node2D


var bonus=false
var baseDamageCheck
var bonusCrit=0

func _ready():
	baseDamageCheck=Global.player.baseDamage
	

func _process(delta):
	if (baseDamageCheck!=Global.player.baseDamage):
		
		baseDamageCheck=Global.player.baseDamage
		
		if bonus:
			removeBonus()

	if ((Global.player.dash.skill==PreLoads.warrior_dash_poseidon and 
	Global.player.dash.quality=="legendary") and !bonus):
	
		bonus=true

		var quality="legendary"
	
		if ( quality=="legendary"):
			bonusCrit=0.5*baseDamageCheck/100
		elif (quality=="divine"):
			bonusCrit=baseDamageCheck
			
		Global.player.percentCritDamage+=bonusCrit

	
	if (!(Global.player.dash.skill==PreLoads.warrior_dash_poseidon and 
	Global.player.dash.quality=="legendary")
	and bonus):
		removeBonus()
		
		
func removeBonus():
	bonus=false

	Global.player.percentCritDamage-=bonusCrit
