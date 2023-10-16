extends Node2D

var battle_max_duration_frames = 55*60

var miningFrame=0

var battleFrame=0

var wave=8


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,2,PreLoads.id009,true)
	spawn(2*60,1,PreLoads.id005,true)
	spawn(5*60,3,PreLoads.id001,true)
	spawn(5*60,1,PreLoads.id005,true)
	spawn(7*60,2,PreLoads.id005,true)
	spawn(9*60,2,PreLoads.id005,true)
	spawn(9*60,3,PreLoads.id009,true)
	spawn(11*60,2,PreLoads.id009,true)
	spawn(11*60,3,PreLoads.id005,true)
	spawn(11*60,3,PreLoads.id001,true)
	spawn(14*60,1,PreLoads.id005,true)
	spawn(15*60,1,PreLoads.id001,true)
	spawn(15*60,1,PreLoads.id005,true)
	spawn(15*60,3,PreLoads.id009,true)
	spawn(17*60,2,PreLoads.id005,true)
	spawn(19*60,2,PreLoads.id005,true)
	spawn(20*60,2,PreLoads.id001,true)
	spawn(23*60,2,PreLoads.id009,true)
	spawn(23*60,3,PreLoads.id001,true)
	spawn(23*60,2,PreLoads.id005,true)
	spawn(25*60,3,PreLoads.id001,true)
	spawn(25*60,1,PreLoads.id009,true)
	spawn(27*60,2,PreLoads.id001,true)
	spawn(28*60,2,PreLoads.id001,true)
	spawn(28*60,2,PreLoads.id005,true)
	spawn(29*60,2,PreLoads.id009,true)
	spawn(29*60,3,PreLoads.id001,true)
	spawn(30*60,4,PreLoads.id001,true)
	spawn(30*60,2,PreLoads.id005,true)
	spawn(30*60,2,PreLoads.id009,true)
	spawn(32*60,4,PreLoads.id001,true)
	spawn(32*60,1,PreLoads.id005,true)
	spawn(32*60,1,PreLoads.id009,true)
	spawn(33*60,2,PreLoads.id001,true)
	spawn(34*60,4,PreLoads.id005,true)
	spawn(34*60,1,PreLoads.id009,true)
	spawn(35*60,4,PreLoads.id005,true)
	spawn(35*60,1,PreLoads.id009,true)
	spawn(37*60,2,PreLoads.id001,true)
	spawn(39*60,2,PreLoads.id001,true)
	spawn(39*60,1,PreLoads.id005,true)
	spawn(40*60,4,PreLoads.id001,true)
	spawn(40*60,1,PreLoads.id005,true)
	spawn(40*60,1,PreLoads.id009,true)
	spawn(43*60,3,PreLoads.id001,true)
	spawn(45*60,4,PreLoads.id001,true)
	spawn(45*60,1,PreLoads.id005,true)
	spawn(46*60,4,PreLoads.id001,true)
	spawn(46*60,1,PreLoads.id005,true)
	spawn(48*60,3,PreLoads.id009,true)
	spawn(48*60,1,PreLoads.id005,true)
	spawn(50*60,2,PreLoads.id001,true)
	spawn(50*60,2,PreLoads.id005,true)
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

