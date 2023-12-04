extends Node2D

var moveSpeedBonus=false
var moveSpeedBonus_frames=-1
var moveSpeedBonus_maxFrames=AllSkillsValues.warrior_dash_zeus_bonusSpeedDuration*60
var dashQuality

func addMoveSpeed(d):
	if (moveSpeedBonus_frames!=-1):
		moveSpeedBonus_frames=0
		return
	moveSpeedBonus_frames=0
	dashQuality=d.quality
	var quality
	var bonus
	
	quality=dashQuality
	if ( quality=="common"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[0]
	elif ( quality=="rare"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[1]
	elif ( quality=="epic"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[2]
	elif ( quality=="legendary"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[3]
	elif ( quality=="divine"):
		bonus=AllSkillsValues.warrior_dash_divine_zeus_moveSpeedPercentBonus
	
	Global.player.moveSpeedPercentBonus+=bonus
	

func removeMoveSpeedBonus():
	moveSpeedBonus=false
	var quality=dashQuality
	var bonus

	if ( quality=="common"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[0]
	elif ( quality=="rare"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[1]
	elif ( quality=="epic"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[2]
	elif ( quality=="legendary"):
		bonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus[3]
	elif ( quality=="divine"):
		bonus=AllSkillsValues.warrior_dash_divine_zeus_moveSpeedPercentBonus
		
	bonus*=(-1)
	
	Global.player.moveSpeedPercentBonus+=bonus

func _process(delta):
	if (moveSpeedBonus_frames>=0):
		moveSpeedBonus_frames+=1
		if (moveSpeedBonus_frames==moveSpeedBonus_maxFrames):
			moveSpeedBonus_frames=-1
			removeMoveSpeedBonus()
