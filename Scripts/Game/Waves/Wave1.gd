extends Node2D

var mining_max_duration_frames = 10*60

var battle_max_duration_frames = 20*60

var miningFrame=0

var battleFrame=0


func _process(delta):
	if (get_parent().wave!=1):
		return
	if (get_parent().mining):
		get_parent().timer=int((mining_max_duration_frames-miningFrame)/60)
		miningFrame+=1
		if (miningFrame==mining_max_duration_frames):
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
	spawn(0*60,4,PreLoads.id001)
	spawn(5*60,5,PreLoads.id001)
	spawn(8*60,6,PreLoads.id001)
	spawn(11*60,3,PreLoads.id001)
	spawn(13*60,4,PreLoads.id001)
	spawn(16*60,3,PreLoads.id001)
	spawn(19*60,4,PreLoads.id001)

	
func spawn(frame,quantity,enemy):
	if (frame!=battleFrame):
		return
	for i in range(0,quantity,1):
		get_parent().spawnX(enemy.instantiate())
		
	##Goblin
	var x = RandomNumberGenerator.new().randi_range(0, 99)
	var chance = 50
	print("Number role: ",x)
	if (x<chance):
		get_parent().spawnX(PreLoads.id002.instantiate())
