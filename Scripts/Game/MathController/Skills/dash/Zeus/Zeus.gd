extends Node2D

var moveSpeedBonus=false
var moveSpeedBonus_frames=-1
var moveSpeedBonus_maxFrames=2*60
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
		bonus=0.05
	elif ( quality=="rare"):
		bonus=0.10
	elif ( quality=="epic"):
		bonus=0.15
	elif ( quality=="legendary"):
		bonus=0.20
	elif ( quality=="divine"):
		bonus=0.30
	
	Global.player.moveSpeedPercentBonus+=bonus
	

func removeMoveSpeedBonus():
	moveSpeedBonus=false
	var quality=dashQuality
	var bonus

	if ( quality=="common"):
		bonus=0.05
	elif ( quality=="rare"):
		bonus=0.10
	elif ( quality=="epic"):
		bonus=0.15
	elif ( quality=="legendary"):
		bonus=0.20
	elif ( quality=="divine"):
		bonus=0.30
		
	bonus*=(-1)
	
	Global.player.moveSpeedPercentBonus+=bonus

func _process(delta):
	if (moveSpeedBonus_frames>=0):
		moveSpeedBonus_frames+=1
		if (moveSpeedBonus_frames==moveSpeedBonus_maxFrames):
			moveSpeedBonus_frames=-1
			removeMoveSpeedBonus()
