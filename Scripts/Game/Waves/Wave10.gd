extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=10


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,6,PreLoads.id001,true)
	spawn(3*60,6,PreLoads.id001,true)
	spawn(6*60,6,PreLoads.id001,true)
	spawn(6*60,3,PreLoads.id009,true)
	spawn(7*60,6,PreLoads.id001,true)
	spawn(9*60,6,PreLoads.id001,true)
	spawn(11*60,6,PreLoads.id001,true)
	spawn(13*60,6,PreLoads.id001,true)
	spawn(13*60,2,PreLoads.id009,true)
	spawn(15*60,6,PreLoads.id001,true)
	spawn(17*60,6,PreLoads.id001,true)
	spawn(19*60,6,PreLoads.id001,true)
	spawn(20*60,2,PreLoads.id004,true)
	spawn(20*60,2,PreLoads.id009,true)
	spawn(20*60,2,PreLoads.id011,true)
	spawn(21*60,6,PreLoads.id001,true)
	spawn(23*60,6,PreLoads.id001,true)
	spawn(25*60,6,PreLoads.id001,true)
	spawn(26*60,3,PreLoads.id009,true)
	spawn(27*60,6,PreLoads.id001,true)
	spawn(29*60,6,PreLoads.id001,true)
	spawn(30*60,3,PreLoads.id003,true)
	spawn(31*60,6,PreLoads.id001,true)
	spawn(31*60,3,PreLoads.id009,true)
	spawn(32*60,2,PreLoads.id003,true)
	spawn(32*60,2,PreLoads.id011,true)
	spawn(33*60,6,PreLoads.id001,true)
	spawn(33*60,6,PreLoads.id003,true)
	spawn(36*60,3,PreLoads.id001,true)
	spawn(36*60,3,PreLoads.id003,true)
	spawn(36*60,3,PreLoads.id009,true)
	spawn(37*60,6,PreLoads.id001,true)
	spawn(37*60,3,PreLoads.id003,true)
	spawn(39*60,2,PreLoads.id004,true)
	spawn(40*60,3,PreLoads.id003,true)
	spawn(40*60,2,PreLoads.id004,true)
	spawn(41*60,2,PreLoads.id004,true)
	spawn(42*60,2,PreLoads.id009,true)
	spawn(42*60,6,PreLoads.id001,true)
	spawn(42*60,2,PreLoads.id003,true)
	spawn(43*60,1,PreLoads.id004,true)
	spawn(44*60,5,PreLoads.id003,true)
	spawn(45*60,2,PreLoads.id004,true)
	spawn(45*60,2,PreLoads.id011,true)
	spawn(46*60,6,PreLoads.id001,true)
	spawn(47*60,2,PreLoads.id009,true)
	spawn(48*60,6,PreLoads.id001,true)
	spawn(48*60,6,PreLoads.id003,true)
	spawn(49*60,2,PreLoads.id004,true)
	spawn(50*60,6,PreLoads.id001,true)
	spawn(50*60,6,PreLoads.id003,true)
	spawn(51*60,2,PreLoads.id004,true)
	spawn(52*60,6,PreLoads.id001,true)
	spawn(52*60,6,PreLoads.id003,true)
	spawn(52*60,2,PreLoads.id009,true)
	spawn(54*60,6,PreLoads.id001,true)
	spawn(54*60,6,PreLoads.id003,true)
	spawn(54*60,2,PreLoads.id004,true)
	spawn(55*60,2,PreLoads.id011,true)
	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

