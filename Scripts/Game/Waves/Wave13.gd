extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=13


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	for i in range(0,int(battle_max_duration_frames/60),10):
		spawn((i+1)*60,9,PreLoads.id011,true)
		spawn((i+6)*60,2,PreLoads.id005,true)
		spawn((i+8)*60,9,PreLoads.id011,true)
		spawn((i+10)*60,3,PreLoads.id007,true)
		spawn((i+10)*60,2,PreLoads.id014,true)
		spawn((i+10)*60,4,PreLoads.id001,true)
		if (i>=30):
			spawn((i+1)*60,2,PreLoads.id009,true)	


func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

