extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=9


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,7,PreLoads.id003,true)
	spawn(3*60,6,PreLoads.id003,true)
	spawn(3*60,5,PreLoads.id010,true)
	spawn(4*60,5,PreLoads.id003,true)
	spawn(5*60,5,PreLoads.id003,true)
	spawn(6*60,5,PreLoads.id003,true)
	spawn(7*60,5,PreLoads.id003,true)
	spawn(8*60,6,PreLoads.id003,true)
	spawn(8*60,5,PreLoads.id010,true)
	spawn(9*60,3,PreLoads.id003,true)
	spawn(9*60,2,PreLoads.id010,true)
	spawn(10*60,10,PreLoads.id003,true)
	spawn(10*60,2,PreLoads.id004,true)
	spawn(11*60,7,PreLoads.id003,true)
	spawn(12*60,7,PreLoads.id003,true)
	spawn(13*60,5,PreLoads.id004,true)
	spawn(13*60,5,PreLoads.id010,true)
	spawn(13*60,4,PreLoads.id003,true)
	spawn(14*60,4,PreLoads.id003,true)
	spawn(16*60,4,PreLoads.id003,true)
	spawn(16*60,2,PreLoads.id004,true)
	spawn(17*60,10,PreLoads.id003,true)
	spawn(18*60,5,PreLoads.id003,true)
	spawn(18*60,4,PreLoads.id010,true)
	spawn(19*60,4,PreLoads.id010,true)
	spawn(19*60,5,PreLoads.id003,true)
	spawn(19*60,1,PreLoads.id004,true)
	spawn(20*60,5,PreLoads.id003,true)
	spawn(22*60,3,PreLoads.id009,true)
	spawn(22*60,1,PreLoads.id004,true)
	spawn(22*60,5,PreLoads.id003,true)
	spawn(23*60,4,PreLoads.id010,true)
	spawn(23*60,5,PreLoads.id003,true)
	spawn(23*60,1,PreLoads.id004,true)
	spawn(24*60,5,PreLoads.id003,true)
	spawn(25*60,5,PreLoads.id003,true)
	spawn(25*60,1,PreLoads.id004,true)
	spawn(26*60,4,PreLoads.id003,true)
	spawn(26*60,2,PreLoads.id004,true)
	spawn(27*60,5,PreLoads.id003,true)
	spawn(28*60,2,PreLoads.id004,true)
	spawn(28*60,5,PreLoads.id003,true)
	spawn(28*60,4,PreLoads.id010,true)
	spawn(29*60,5,PreLoads.id003,true)
	spawn(30*60,5,PreLoads.id003,true)
	spawn(33*60,2,PreLoads.id004,true)
	spawn(33*60,5,PreLoads.id003,true)
	spawn(33*60,4,PreLoads.id010,true)
	spawn(34*60,2,PreLoads.id004,true)
	spawn(34*60,5,PreLoads.id003,true)
	spawn(34*60,4,PreLoads.id010,true)
	spawn(35*60,5,PreLoads.id003,true)
	spawn(37*60,2,PreLoads.id004,true)
	spawn(37*60,5,PreLoads.id003,true)
	spawn(39*60,2,PreLoads.id004,true)
	spawn(39*60,5,PreLoads.id003,true)
	spawn(39*60,4,PreLoads.id010,true)
	spawn(39*60,3,PreLoads.id009,true)
	spawn(40*60,2,PreLoads.id004,true)
	spawn(40*60,5,PreLoads.id003,true)
	spawn(41*60,5,PreLoads.id003,true)
	spawn(42*60,5,PreLoads.id003,true)
	spawn(43*60,5,PreLoads.id003,true)
	spawn(43*60,4,PreLoads.id010,true)
	spawn(44*60,5,PreLoads.id003,true)
	spawn(45*60,5,PreLoads.id003,true)
	spawn(47*60,3,PreLoads.id009,true)
	spawn(47*60,2,PreLoads.id004,true)
	spawn(47*60,5,PreLoads.id003,true)
	spawn(48*60,5,PreLoads.id003,true)
	spawn(48*60,4,PreLoads.id010,true)
	spawn(49*60,2,PreLoads.id004,true)
	spawn(49*60,5,PreLoads.id003,true)
	spawn(51*60,5,PreLoads.id003,true)
	spawn(53*60,4,PreLoads.id010,true)
	spawn(53*60,2,PreLoads.id004,true)
	spawn(53*60,5,PreLoads.id003,true)
	spawn(55*60,5,PreLoads.id003,true)
	spawn(55*60,3,PreLoads.id009,true)
	spawn(55*60,2,PreLoads.id004,true)
	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

