extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=19


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	for i in range(0,int(battle_max_duration_frames/60),16):
		spawn((i+1)*60,1,PreLoads.id020,true)
		spawn((i+2)*60,1,PreLoads.id001,true)
		spawn((i+3)*60,1,PreLoads.id003,true)
		spawn((i+4)*60,1,PreLoads.id004,true)
		spawn((i+5)*60,1,PreLoads.id005,true)
		spawn((i+6)*60,1,PreLoads.id006,true)
		spawn((i+7)*60,1,PreLoads.id007,true)
		spawn((i+8)*60,1,PreLoads.id008,true)
		spawn((i+9)*60,1,PreLoads.id009,true)
		spawn((i+10)*60,1,PreLoads.id010,true)
		spawn((i+11)*60,1,PreLoads.id011,true)
		spawn((i+12)*60,1,PreLoads.id012,true)
		spawn((i+13)*60,1,PreLoads.id014,true)
		spawn((i+14)*60,1,PreLoads.id016,true)
		spawn((i+15)*60,1,PreLoads.id017,true)
		spawn((i+16)*60,1,PreLoads.id019,true)

			

func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

