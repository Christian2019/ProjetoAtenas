extends Node2D

var tick =0
var waitTick=2

func _process(delta):
	if (tick == waitTick):
		updateTimeToNextWave()
		updateResources()
	
	if (tick < waitTick):
		tick+=1
		
func updateResources():
	$Frontground/Wood/Label.text =  str("Wood ",Global.player.wood)
	$Frontground/Gold/Label.text =  str("Gold ",Global.player.gold)
	$Frontground/Stone/Label.text =  str("Stone ",Global.player.stone)
	
func updateTimeToNextWave():
	$Frontground/TimeLine/Label2.text = str(Global.Game.get_node("WaveController").timer,"s")


