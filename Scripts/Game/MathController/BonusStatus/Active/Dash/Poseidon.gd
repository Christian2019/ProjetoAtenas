extends Node2D


var bonus=false
var baseDamageCheck
var bonusCrit=0
var quality

func _ready():
	baseDamageCheck=Global.player.baseDamage
	

func _process(delta):
	process_mode = Node.PROCESS_MODE_ALWAYS
	if (baseDamageCheck!=Global.player.baseDamage):
		
		baseDamageCheck=Global.player.baseDamage
		
		if bonus:
			removeBonus()

	if !bonus and verifyActivation():
	
		bonus=true
		
		if ( quality=="legendary"):
			bonusCrit=AllSkillsValues.warrior_dash_poseidon_destructionInstinct*baseDamageCheck/100
		elif (quality=="divine"):
			bonusCrit=AllSkillsValues.warrior_dash_divine_poseidon_destructionInstinct*baseDamageCheck/100
			
		Global.player.percentCritDamage+=bonusCrit

	
	if bonus and !verifyActivation():
		removeBonus()
		
		
func removeBonus():
	bonus=false
	Global.player.percentCritDamage-=bonusCrit

func verifyActivation():
	if (Global.player.dash.skill==PreLoads.warrior_dash_poseidon and 
	Global.player.dash.quality=="legendary"):
		quality="legendary"
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_HadesPoseidon):
		quality="divine"
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusPoseidon):
		quality="divine"
		return true
		
	return false
