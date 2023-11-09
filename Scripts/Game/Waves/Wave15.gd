extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=15


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	for i in range(0,int(battle_max_duration_frames/60),12):
		spawn((i+1)*60,1,PreLoads.id016,true)
		spawn((i+1)*60,3,PreLoads.id003,true)
		spawn((i+1)*60,3,PreLoads.id010,true)
		spawn((i+1)*60,8,PreLoads.id001,true)
		spawn((i+3)*60,4,PreLoads.id011,true)
		spawn((i+4)*60,1,PreLoads.id008,true)
		spawn((i+5)*60,1,PreLoads.id005,true)
		spawn((i+12)*60,1,PreLoads.id014,true)



func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

