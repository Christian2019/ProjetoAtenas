extends Node2D

var battle_max_duration_frames = 35*60

var miningFrame=0

var battleFrame=0

var wave=4


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,2,PreLoads.id005,true)
	spawn(3*60,2,PreLoads.id003,true)
	spawn(4*60,7,PreLoads.id001,true)
	spawn(6*60,2,PreLoads.id005,true)
	spawn(7*60,7,PreLoads.id001,true)
	spawn(8*60,2,PreLoads.id003,true)
	spawn(8*60,2,PreLoads.id001,true)
	spawn(10*60,6,PreLoads.id001,true)
	spawn(11*60,2,PreLoads.id005,true)
	spawn(12*60,7,PreLoads.id001,true)
	spawn(15*60,3,PreLoads.id003,true)
	spawn(16*60,2,PreLoads.id005,true)
	spawn(16*60,7,PreLoads.id001,true)
	spawn(18*60,2,PreLoads.id003,true)
	spawn(19*60,7,PreLoads.id001,true)
	spawn(21*60,3,PreLoads.id005,true)
	spawn(21*60,2,PreLoads.id003,true)
	spawn(22*60,7,PreLoads.id001,true)
	spawn(24*60,2,PreLoads.id003,true)
	spawn(25*60,7,PreLoads.id001,true)
	spawn(25*60,3,PreLoads.id005,true)
	spawn(26*60,2,PreLoads.id005,true)
	spawn(27*60,2,PreLoads.id003,true)
	spawn(29*60,7,PreLoads.id001,true)
	spawn(30*60,2,PreLoads.id003,true)
	spawn(31*60,7,PreLoads.id001,true)
	spawn(31*60,3,PreLoads.id005,true)




	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

