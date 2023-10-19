extends Node2D

var battle_max_duration_frames = 100*60

var miningFrame=0

var battleFrame=0

var wave=11

func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(9*60,1,PreLoads.id013,true)

	for i in range(0,int(battle_max_duration_frames/60),5):
		spawn(i*60,5,PreLoads.id001,true)
		spawn((i+1)*60,2,PreLoads.id004,true)
		spawn((i+2)*60,2,PreLoads.id007,true)
		spawn((i+3)*60,5,PreLoads.id001,true)
		spawn((i+4)*60,2,PreLoads.id005,true)

func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

