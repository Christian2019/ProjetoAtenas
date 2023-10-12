extends Node2D

var mining_max_duration_frames = 10*60

var wave = 1

var timer = 0

var mining = true

var xDuration=1

var maxWave=2

func battleStart():
	Global.Game.get_node("SoundController").startBattleMusic()
	mining=false
	
func battleEnd():
	Global.Game.get_node("SoundController").endBattleMusic()
	mining=true
	for i in range(0,Global.player.permissions.size(),1):
		Global.player.permissions[i]=true
	
	clearWave()

func clearWave():
	clearChildren("Enemies")
	clearChildren("Instances/Turrets")
	clearChildren("Instances/Projectiles")
	clearChildren("Instances/X")

func clearChildren(path):
	for i in range(0,Global.Game.get_node(path).get_child_count(),1):
		var instance = Global.Game.get_node(path).get_child(i)
		if (instance.has_method("destroy")):
			instance.destroy()
		else:
			instance.queue_free()

func spawnX(enemy):
	var vector= getAllowRandomSpawnPosition()
	enemy.global_position = vector
	var x = PreLoads.x.instantiate()
	x.global_position=vector
	Global.Game.get_node("Instances/X").call_deferred("add_child",x)
	Global.timerCreator("spawnEnemy",xDuration,[enemy,x],self)
	
func spawnGoblin():
	var x = RandomNumberGenerator.new().randi_range(0, 99)
	var chance = 50
	if (x<chance):
		spawnX(PreLoads.id002.instantiate())	

func spawnEnemy(enemy,x):
	if (mining):
		return
	x.queue_free()
	get_parent().get_node("Enemies").call_deferred("add_child",enemy)

func getAllowRandomSpawnPosition():
	var rng = RandomNumberGenerator.new()
	var x = rng.randi_range(50, 2450)
	var y = rng.randi_range(50, 1225)
	if (x>1100 and x<1500 and y>437 and y<761):
		return getAllowRandomSpawnPosition()
	return Vector2(x,y)

	
