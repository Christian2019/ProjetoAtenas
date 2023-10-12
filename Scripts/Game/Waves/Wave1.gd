extends Node2D

var battle_max_duration_frames = 20*60

var miningFrame=0

var battleFrame=0


func _process(delta):
	if (get_parent().wave!=1):
		return
	if (get_parent().mining):
		get_parent().timer=int((get_parent().mining_max_duration_frames-miningFrame)/60)
		miningFrame+=1
		if (miningFrame==get_parent().mining_max_duration_frames):
			get_parent().battleStart()
	else:
		waveBehavior()
		get_parent().timer=int((battle_max_duration_frames-battleFrame)/60)
		battleFrame+=1
		if (battleFrame>=battle_max_duration_frames):
			if (get_parent().wave<get_parent().maxWave):
				get_parent().wave+=1
			else:
				miningFrame=0
				battleFrame=0
			get_parent().battleEnd()
			return
	
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

