extends Node2D

var battle_max_duration_frames = 60*60

var miningFrame=0

var battleFrame=0

var wave=11


func _process(delta):
	get_parent().waveTimer(self)
	
func waveBehavior():
	spawn(1*60,3,PreLoads.id012,true)

	
	
func spawn(frame,quantity,enemy,goblin):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
	
	if (goblin):
		get_parent().spawnGoblin()

