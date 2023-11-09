extends Node2D

var battle_max_duration_frames = 45*60

var miningFrame=0

var battleFrame=0

var wave=6


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,4,PreLoads.id004,true)
	spawn(3*60,3,PreLoads.id003,true)
	spawn(6*60,3,PreLoads.id003,true)
	spawn(6*60,4,PreLoads.id004,true)
	spawn(8*60,4,PreLoads.id003,true)
	spawn(10*60,3,PreLoads.id003,true)
	spawn(10*60,3,PreLoads.id004,true)
	spawn(10*60,1,PreLoads.id006,true)
	spawn(12*60,3,PreLoads.id003,true)
	spawn(13*60,3,PreLoads.id004,true)
	spawn(14*60,2,PreLoads.id003,true)
	spawn(15*60,3,PreLoads.id007,true)
	spawn(16*60,3,PreLoads.id003,true)
	spawn(16*60,5,PreLoads.id004,true)
	spawn(18*60,4,PreLoads.id003,true)
	spawn(18*60,1,PreLoads.id006,true)
	spawn(19*60,5,PreLoads.id004,true)
	spawn(20*60,4,PreLoads.id003,true)
	spawn(20*60,2,PreLoads.id007,true)
	spawn(22*60,2,PreLoads.id003,true)
	spawn(22*60,4,PreLoads.id004,true)
	spawn(24*60,2,PreLoads.id003,true)
	spawn(25*60,6,PreLoads.id001,true)
	spawn(25*60,2,PreLoads.id007,true)
	spawn(25*60,4,PreLoads.id004,true)
	spawn(26*60,2,PreLoads.id003,true)
	spawn(26*60,1,PreLoads.id006,true)
	spawn(28*60,3,PreLoads.id003,true)
	spawn(28*60,3,PreLoads.id004,true)
	spawn(30*60,5,PreLoads.id001,true)
	spawn(30*60,3,PreLoads.id003,true)
	spawn(30*60,2,PreLoads.id007,true)
	spawn(31*60,4,PreLoads.id004,true)
	spawn(32*60,2,PreLoads.id003,true)
	spawn(34*60,4,PreLoads.id001,true)
	spawn(34*60,4,PreLoads.id004,true)
	spawn(34*60,1,PreLoads.id006,true)
	spawn(35*60,2,PreLoads.id007,true)
	spawn(37*60,3,PreLoads.id003,true)
	spawn(37*60,4,PreLoads.id004,true)
	spawn(40*60,4,PreLoads.id001,true)
	spawn(40*60,2,PreLoads.id007,true)


func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

