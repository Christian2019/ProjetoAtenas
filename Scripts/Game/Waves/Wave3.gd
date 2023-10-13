extends Node2D

var battle_max_duration_frames = 30*60

var miningFrame=0

var battleFrame=0

var wave=3


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	#spawn(1*60,3,PreLoads.id004,true)
	spawn(1*60,4,PreLoads.id001,true)
	spawn(4*60,6,PreLoads.id001,true)
	spawn(6*60,4,PreLoads.id001,true)
	spawn(9*60,2,PreLoads.id004,true)	
	spawn(9*60,3,PreLoads.id003,true)
	spawn(9*60,4,PreLoads.id001,true)
	spawn(13*60,4,PreLoads.id001,true)
	spawn(13*60,2,PreLoads.id004,true)
	spawn(16*60,4,PreLoads.id001,true)
	spawn(16*60,3,PreLoads.id004,true)
	spawn(16*60,4,PreLoads.id003,true)
	spawn(20*60,3,PreLoads.id004,true)
	spawn(20*60,4,PreLoads.id003,true)
	spawn(23*60,4,PreLoads.id001,true)
	spawn(23*60,3,PreLoads.id004,true)
	spawn(23*60,4,PreLoads.id003,true)
	spawn(25*60,4,PreLoads.id001,true)
	spawn(25*60,3,PreLoads.id004,true)
	spawn(25*60,4,PreLoads.id003,true)
	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

