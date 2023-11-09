extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=18


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	for i in range(0,int(battle_max_duration_frames/60),10):
		spawn((i+1)*60,2,PreLoads.id019,true)
		spawn((i+2)*60,3,PreLoads.id011,true)
		spawn((i+3)*60,1,PreLoads.id017,true)
		if i>20:
			spawn((i+4)*60,10,PreLoads.id005,true)
		if i>30:
			spawn((i+5)*60,2,PreLoads.id016,true)
			spawn((i+1)*60,3,PreLoads.id008,true)
			spawn((i+6)*60,3,PreLoads.id008,true)
			

func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

