extends Node2D

var activate=false

var rng


func _ready():
	rng=RandomNumberGenerator.new()

func _process(delta):
	if (!activate and verifyActivation()):
		activate=true
	if(activate and !verifyActivation()):
		activate=false

func effect():
	if (activate):
		var r = rng.randi_range(0, 100)
		var quality
		
		if (Global.player.dash.skill==PreLoads.warrior_dash_divine_HadesPoseidon or
		Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusPoseidon):
			quality="divine"
		else:
			quality=Global.player.dash.quality
			
		var breakPoint
		
		if ( quality=="common"):
			breakPoint=AllSkillsValues.warrior_dash_poseidon_chance[0]
		elif ( quality=="rare"):
			breakPoint=AllSkillsValues.warrior_dash_poseidon_chance[1]
		elif ( quality=="epic"):
			breakPoint=AllSkillsValues.warrior_dash_poseidon_chance[2]
		elif ( quality=="legendary"):
			breakPoint=AllSkillsValues.warrior_dash_poseidon_chance[3]
		elif (quality=="divine"):
			breakPoint=AllSkillsValues.warrior_dash_divine_poseidon_chance
			
		if (r<=breakPoint):
			Global.player.baseDamage+=1
			Global.timerCreator("removeBD",5,[],self)
		

func removeBD():
	Global.player.baseDamage-=1

func verifyActivation():
	if (Global.player.dash.skill==PreLoads.warrior_dash_poseidon):
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_HadesPoseidon):
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusPoseidon):
		return true
		
	return false
	
