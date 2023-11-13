extends Node2D

var moveSpeedBonus=false
var moveSpeedBonus_frames=-1
var moveSpeedBonus_maxFrames=2*60
var dash

func addMoveSpeed(d):
	if (moveSpeedBonus_frames!=-1):
		moveSpeedBonus_frames=0
		return
	moveSpeedBonus_frames=0
	dash=d
	var quality
	var bonus
	
	#VERIFICAO DIVINE 30
	
	quality=dash.quality
	if ( quality=="common"):
		bonus=0.05
	elif ( quality=="rare"):
		bonus=0.10
	elif ( quality=="epic"):
		bonus=0.15
	elif ( quality=="legendary"):
		bonus=0.20
	
	Global.player.moveSpeedPercentBonus+=bonus
	

func removeMoveSpeedBonus():
	moveSpeedBonus=false
	var quality=dash.quality
	var bonus
	#VERIFICAO DIVINE 30
	if ( quality=="common"):
		bonus=0.05
	elif ( quality=="rare"):
		bonus=0.10
	elif ( quality=="epic"):
		bonus=0.15
	elif ( quality=="legendary"):
		bonus=0.20
		
	bonus*=(-1)
	
	Global.player.moveSpeedPercentBonus+=bonus

func _process(delta):
	if (moveSpeedBonus_frames>=0):
		moveSpeedBonus_frames+=1
		if (moveSpeedBonus_frames==moveSpeedBonus_maxFrames):
			moveSpeedBonus_frames=-1
			removeMoveSpeedBonus()
