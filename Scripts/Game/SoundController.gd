extends Node2D
var enableSound = true

var transitionTime = 5

var waveMusic
var farmingMusic

func _ready():
	waveMusic=$WaveMusic
	farmingMusic=$AOEMusic


func startBattleMusic(wave):
	if (wave==11 or wave==14 or wave==17):
		waveMusic=$EliteMusic
		controllMusic(0,true,10)
	else:
		waveMusic=$WaveMusic
		controllMusic(0,true,0)
	waveMusic.playing=true
	
	

func endBattleMusic():
	farmingMusic.playing=true
	controllMusic(0,false,0)
	
func enableDisableSound():
	if (enableSound):
		enableSound=false
		for i in range(0,get_child_count(),1):
			var sound = get_child(i)
			if (sound.get_child_count()==0):
				sound.set_volume_db(-40) 
				
	else:
		enableSound=true
		for i in range(0,get_child_count(),1):
			var sound = get_child(i)
			if (sound.get_child_count()==0):
				sound.set_volume_db(0)

func controllMusic(timer,waveTime,startVolume):
	timer+=1
	if (waveTime):
		if (enableSound):
			farmingMusic.set_volume_db(timer*(-1))
			waveMusic.set_volume_db(startVolume+timer-transitionTime) 
		if (timer == transitionTime):
			farmingMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,true,startVolume],self)
	else:
		if (enableSound):
			farmingMusic.set_volume_db(startVolume+timer-transitionTime-5)
			waveMusic.set_volume_db(timer*(-1)) 
		if (timer == transitionTime):
			waveMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,false,startVolume],self)
			

