extends Node2D

var nextWaveTime =0

var start_bool = true
func start():
	if (start_bool):
		start_bool=false
		passTime()

func _process(delta):
	if (Global.Game!=null):
		start()
		updateTimeToNextWave()
	if (Global.player!=null):
		updateResources()
	
func updateResources():
	$Frontground/Wood/Label.text =  str("Wood ",Global.player.wood)
	$Frontground/Gold/Label.text =  str("Gold ",Global.player.gold)
	$Frontground/Stone/Label.text =  str("Stone ",Global.player.stone)
	
func updateTimeToNextWave():
	$Frontground/TimeLine/Label2.text = str(nextWaveTime,"s")

func passTime():
	nextWaveTime-=1
	if (nextWaveTime==-1):
		nextWaveTime= Global.Game.get_node("Spawners/Spawner_W").wave_timer-1
	Global.timerCreator("passTime",1,[],self)
