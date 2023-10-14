extends Node2D

var battle_max_duration_frames = 40*60

var miningFrame=0

var battleFrame=0

var wave=5


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,8,PreLoads.id001,true)
	spawn(3*60,3,PreLoads.id003,true)
	spawn(5*60,8,PreLoads.id001,true)
	spawn(7*60,1,PreLoads.id003,true)
	spawn(8*60,4,PreLoads.id003,true)
	spawn(9*60,8,PreLoads.id001,true)
	spawn(12*60,4,PreLoads.id003,true)
	spawn(13*60,8,PreLoads.id001,true)
	spawn(15*60,2,PreLoads.id006,true)
	spawn(15*60,1,PreLoads.id004,true)
	spawn(15*60,4,PreLoads.id003,true)
	spawn(17*60,3,PreLoads.id003,true)
	spawn(17*60,8,PreLoads.id001,true)
	spawn(19*60,3,PreLoads.id003,true)
	spawn(19*60,2,PreLoads.id004,true)
	spawn(21*60,8,PreLoads.id001,true)
	spawn(21*60,1,PreLoads.id004,true)
	spawn(21*60,3,PreLoads.id003,true)
	spawn(23*60,3,PreLoads.id004,true)
	spawn(23*60,1,PreLoads.id006,true)
	spawn(23*60,5,PreLoads.id003,true)
	spawn(25*60,1,PreLoads.id006,true)
	spawn(25*60,5,PreLoads.id001,true)
	spawn(25*60,2,PreLoads.id003,true)
	spawn(25*60,2,PreLoads.id005,true)
	spawn(27*60,2,PreLoads.id004,true)
	spawn(27*60,3,PreLoads.id003,true)
	spawn(29*60,7,PreLoads.id001,true)
	spawn(29*60,3,PreLoads.id003,true)
	spawn(31*60,3,PreLoads.id003,true)
	spawn(31*60,2,PreLoads.id004,true)
	spawn(31*60,1,PreLoads.id006,true)
	spawn(33*60,8,PreLoads.id001,true)
	spawn(33*60,2,PreLoads.id003,true)
	spawn(35*60,1,PreLoads.id006,true)
	spawn(35*60,5,PreLoads.id001,true)
	spawn(35*60,2,PreLoads.id003,true)
	spawn(35*60,2,PreLoads.id005,true)
	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

