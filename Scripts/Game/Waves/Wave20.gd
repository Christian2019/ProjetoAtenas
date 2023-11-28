extends Node2D

var battle_max_duration_frames = 10000*60

var miningFrame=0

var battleFrame=0

var wave=20


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	#spawn(1*60,1,PreLoads.targetDummy,false)
	spawn(1*60,1,PreLoads.id001,false)
	spawn(1*60,1,PreLoads.id003,false)
	spawn(1*60,1,PreLoads.id010,false)
	spawn(1*60,1,PreLoads.id011,false)
	spawn(1*60,1,PreLoads.id004,false)
	spawn(1*60,1,PreLoads.id006,false)
	spawn(1*60,1,PreLoads.id009,false)
	spawn(1*60,1,PreLoads.id019,false)
			

func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

