extends Node2D
var enableSound = true

var transitionTime = 5


func startBattleMusic():
	$WaveMusic.playing=true
	controllMusic(0,true)
	

func endBattleMusic():
	$AOEMusic.playing=true
	controllMusic(0,false)
	
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

func controllMusic(timer,waveMusic):
	timer+=1
	print(timer)
	if (waveMusic):
		if (enableSound):
			$AOEMusic.set_volume_db(timer*(-1))
			$WaveMusic.set_volume_db(timer-transitionTime) 
		if (timer == transitionTime):
			$AOEMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,true],self)
	else:
		if (enableSound):
			$AOEMusic.set_volume_db(timer-transitionTime-5)
			$WaveMusic.set_volume_db(timer*(-1)) 
		if (timer == transitionTime):
			$WaveMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,false],self)
