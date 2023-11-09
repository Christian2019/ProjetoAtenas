extends Node2D

var battle_max_duration_frames = 100*60

var miningFrame=0

var battleFrame=0

var wave=14

func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(3*60,6,PreLoads.id003,true) 
	spawn(7*60,1,PreLoads.id015,true)
	for i in range(10,int(battle_max_duration_frames/60),10):
		spawn((i+1)*60,1,PreLoads.id011,true)
		spawn((i+5)*60,6,PreLoads.id003,true)



func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

