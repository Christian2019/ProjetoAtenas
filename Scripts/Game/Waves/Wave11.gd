extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=11


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,3,PreLoads.id012,true)
	spawn(3*60,1,PreLoads.id012,true)
	spawn(3*60,4,PreLoads.id001,true)
	spawn(5*60,3,PreLoads.id004,true)
	spawn(6*60,2,PreLoads.id012,true)
	spawn(8*60,3,PreLoads.id004,true)
	spawn(9*60,3,PreLoads.id001,true)
	spawn(11*60,3,PreLoads.id004,true)
	spawn(11*60,2,PreLoads.id012,true)
	spawn(12*60,2,PreLoads.id007,true)
	spawn(13*60,1,PreLoads.id012,true)
	spawn(14*60,3,PreLoads.id004,true)
	spawn(14*60,3,PreLoads.id001,true)
	spawn(16*60,3,PreLoads.id012,true)
	spawn(17*60,3,PreLoads.id004,true)
	spawn(18*60,3,PreLoads.id001,true)
	spawn(20*60,4,PreLoads.id004,true)
	spawn(21*60,3,PreLoads.id012,true)
	spawn(21*60,4,PreLoads.id001,true)
	spawn(22*60,2,PreLoads.id007,true)
	spawn(23*60,3,PreLoads.id001,true)
	spawn(23*60,1,PreLoads.id012,true)
	spawn(23*60,3,PreLoads.id004,true)
	spawn(24*60,3,PreLoads.id001,true)
	spawn(25*60,2,PreLoads.id001,true)
	spawn(25*60,3,PreLoads.id005,true)
	spawn(26*60,3,PreLoads.id001,true)
	spawn(26*60,1,PreLoads.id012,true)
	spawn(27*60,3,PreLoads.id001,true)
	spawn(28*60,4,PreLoads.id001,true)
	spawn(28*60,2,PreLoads.id005,true)
	spawn(29*60,2,PreLoads.id004,true)
	spawn(29*60,1,PreLoads.id001,true)
	spawn(30*60,4,PreLoads.id001,true)
	spawn(31*60,4,PreLoads.id001,true)
	spawn(31*60,2,PreLoads.id005,true)
	spawn(31*60,3,PreLoads.id012,true)
	spawn(32*60,4,PreLoads.id001,true)
	spawn(32*60,2,PreLoads.id007,true)
	spawn(32*60,2,PreLoads.id004,true)
	spawn(33*60,2,PreLoads.id001,true)
	spawn(34*60,2,PreLoads.id005,true)
	spawn(34*60,2,PreLoads.id001,true)
	spawn(35*60,3,PreLoads.id004,true)
	spawn(35*60,3,PreLoads.id001,true)
	spawn(36*60,2,PreLoads.id001,true)
	spawn(36*60,1,PreLoads.id012,true)
	spawn(37*60,1,PreLoads.id005,true)
	spawn(37*60,1,PreLoads.id001,true)
	spawn(38*60,3,PreLoads.id004,true)
	spawn(38*60,1,PreLoads.id001,true)
	spawn(39*60,3,PreLoads.id001,true)
	spawn(40*60,3,PreLoads.id005,true)
	spawn(40*60,2,PreLoads.id001,true)
	spawn(41*60,2,PreLoads.id004,true)
	spawn(41*60,2,PreLoads.id012,true)
	spawn(41*60,3,PreLoads.id001,true)
	spawn(42*60,2,PreLoads.id007,true)
	spawn(42*60,3,PreLoads.id001,true)
	spawn(43*60,1,PreLoads.id012,true)
	spawn(43*60,3,PreLoads.id001,true)
	spawn(43*60,3,PreLoads.id005,true)
	spawn(44*60,4,PreLoads.id004,true)
	spawn(45*60,3,PreLoads.id001,true)
	spawn(46*60,1,PreLoads.id005,true)
	spawn(46*60,2,PreLoads.id012,true)
	spawn(47*60,2,PreLoads.id004,true)
	spawn(47*60,2,PreLoads.id001,true)
	spawn(48*60,3,PreLoads.id001,true)
	spawn(49*60,3,PreLoads.id001,true)
	spawn(50*60,3,PreLoads.id001,true)
	spawn(50*60,3,PreLoads.id004,true)
	spawn(50*60,1,PreLoads.id012,true)
	spawn(51*60,4,PreLoads.id001,true)
	spawn(51*60,1,PreLoads.id012,true)
	spawn(52*60,4,PreLoads.id007,true)
	spawn(52*60,2,PreLoads.id005,true)
	spawn(53*60,1,PreLoads.id012,true)
	spawn(53*60,3,PreLoads.id004,true)
	spawn(53*60,1,PreLoads.id001,true)
	spawn(55*60,4,PreLoads.id001,true)
	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

