extends Node2D

var battle_max_duration_frames = 50*60

var miningFrame=0

var battleFrame=0

var wave=7


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,7,PreLoads.id001,true)
	spawn(3*60,5,PreLoads.id001,true)
	spawn(3*60,5,PreLoads.id008,true)
	spawn(5*60,7,PreLoads.id001,true)
	spawn(7*60,7,PreLoads.id001,true)
	spawn(10*60,5,PreLoads.id004,true)
	spawn(12*60,7,PreLoads.id001,true)
	spawn(12*60,2,PreLoads.id008,true)
	spawn(15*60,5,PreLoads.id004,true)
	spawn(17*60,5,PreLoads.id001,true)
	spawn(20*60,5,PreLoads.id001,true)
	spawn(20*60,5,PreLoads.id004,true)
	spawn(22*60,5,PreLoads.id001,true)
	spawn(25*60,5,PreLoads.id004,true)
	spawn(27*60,5,PreLoads.id001,true)
	spawn(30*60,5,PreLoads.id001,true)
	spawn(33*60,5,PreLoads.id001,true)
	spawn(33*60,5,PreLoads.id004,true)
	spawn(35*60,2,PreLoads.id008,true)
	spawn(38*60,4,PreLoads.id005,true)
	spawn(38*60,5,PreLoads.id004,true)
	spawn(38*60,2,PreLoads.id008,true)
	spawn(39*60,5,PreLoads.id001,true)
	spawn(40*60,4,PreLoads.id005,true)
	spawn(40*60,4,PreLoads.id004,true)
	spawn(43*60,2,PreLoads.id008,true)
	spawn(45*60,5,PreLoads.id005,true)

func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

