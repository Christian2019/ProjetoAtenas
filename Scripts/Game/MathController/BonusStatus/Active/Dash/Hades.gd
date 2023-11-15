extends Node2D

#Stats Check
var lastSkill
var lastQuality
var lastHPRecovering
var hp50Percert=false
var quality


#Bonus
var bonus=false
var bonusHPRecovering


func _process(delta):
	
	recalculate()

	if !bonus and verifyActivation():
	
		bonus=true
	
		if ( quality=="common"):
			bonusHPRecovering=5
		elif ( quality=="rare"):
			bonusHPRecovering=10
		elif ( quality=="epic"):
			bonusHPRecovering=20
		elif ( quality=="legendary"):
			bonusHPRecovering=50
			if hp50Percert:
				bonusHPRecovering=(bonusHPRecovering+Global.player.hpRegeneration)*2
				bonusHPRecovering-=Global.player.hpRegeneration
		elif (quality=="divine"):
			bonusHPRecovering=100
			if hp50Percert:
				bonusHPRecovering=(bonusHPRecovering+Global.player.hpRegeneration)*3
				bonusHPRecovering-=Global.player.hpRegeneration
		
	
		Global.player.hpRegeneration+=bonusHPRecovering
		lastHPRecovering=Global.player.hpRegeneration
		lastSkill=Global.player.dash.skill
		lastQuality=Global.player.dash.quality

	
	

func recalculate():
	checkHp()
	
	if (lastHPRecovering!=Global.player.hpRegeneration or
	lastSkill!=Global.player.dash.skill or
 	lastQuality!=Global.player.dash.quality):
			
		if bonus:
			removeBonus()
			
func checkHp():
	if (Global.player.hp<=Global.player.maxHp/2 and !hp50Percert):
		hp50Percert=true
		if bonus:
			removeBonus()
			
	elif (Global.player.hp>Global.player.maxHp/2 and hp50Percert):
		hp50Percert=false
		if bonus:
			removeBonus()
		
func removeBonus():
	bonus=false
	Global.player.hpRegeneration-=bonusHPRecovering
	
func verifyActivation():
	if (Global.player.dash.skill==PreLoads.warrior_dash_hades):
		quality = Global.player.dash.quality
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_HadesPoseidon):
		quality="divine"
		return true
	if (Global.player.dash.skill==PreLoads.warrior_dash_divine_ZeusHades):
		quality="divine"
		return true
		
	return false
