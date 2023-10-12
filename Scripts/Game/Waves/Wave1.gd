extends Node2D

var battle_max_duration_frames = 20*60

var miningFrame=0

var battleFrame=0

var wave=1


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(0*60,4,PreLoads.id001,true)
	spawn(5*60,5,PreLoads.id001,true)
	spawn(8*60,6,PreLoads.id001,true)
	spawn(11*60,3,PreLoads.id001,true)
	spawn(13*60,4,PreLoads.id001,true)
	spawn(16*60,3,PreLoads.id001,true)
	spawn(19*60,4,PreLoads.id001,true)

	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

