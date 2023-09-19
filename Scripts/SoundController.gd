extends Node2D

var waveMusicPlaying = false

var transitionTime = 5
	
func startBattleMusic():
	$WaveMusic.playing=true
	controllMusic(0,true)
	

func endBattleMusic():
	$AOEMusic.playing=true
	controllMusic(0,false)
	

func controllMusic(timer,waveMusic):
	timer+=1
	print(timer)
	if (waveMusic):
		$AOEMusic.set_volume_db(timer*(-1))
		$WaveMusic.set_volume_db(timer-transitionTime) 
		if (timer == transitionTime):
			$AOEMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,true],self)
	else:
		$AOEMusic.set_volume_db(timer-transitionTime-5)
		$WaveMusic.set_volume_db(timer*(-1)) 
		if (timer == transitionTime):
			$WaveMusic.playing=false
		else:
			Global.timerCreator("controllMusic",0.5,[timer,false],self)
