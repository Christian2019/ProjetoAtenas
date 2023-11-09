extends Node2D
var enableSound = true

var transitionTime = 5

var waveMusic
var farmingMusic

func _ready():
	waveMusic=$WaveMusic
	farmingMusic=$AOEMusic
	farmingMusic.set_volume_db(-20)
	farmingMusic.playing=true


func startBattleMusic(elite):
	if (elite):
		waveMusic=$EliteMusic
		#controllMusic(0,true,-10)
		waveMusic.set_volume_db(-10)
		
	else:
		waveMusic=$WaveMusic
		#controllMusic(0,true,-20)
		waveMusic.set_volume_db(-20)
	waveMusic.playing=true
	farmingMusic.playing=false
	

func endBattleMusic():
	farmingMusic.playing=true
	waveMusic.playing=false
	#controllMusic(0,false,-20)
	
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
			

