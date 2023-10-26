extends Node2D

var mining_max_duration_frames = 1*60

var wave = 18
var maxWave=18

var timer = 0

var mining = true

var xDuration=1

func _ready():
	Global.WaveController=self


func battleStart():
	if (wave==11 or wave==14 or wave==17):
		Global.Game.get_node("SoundController").startBattleMusic(true)
		var frameBackground=0
		if (wave==14):
			frameBackground=1
		elif (wave==17):
			frameBackground=2
			
		Global.Game.get_node("Zones/ModifyGround").start(0, 0.4,frameBackground)
	else:
		Global.Game.get_node("SoundController").startBattleMusic(false)
	mining=false
	
func battleEnd():
	if (wave==11 or wave==14 or wave==17):
		Global.Game.get_node("Zones/ModifyGround").finish()
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
	var vector= getAllowRandomSpawnPosition(enemy)
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

func getAllowRandomSpawnPosition(enemy):
	var rng = RandomNumberGenerator.new()
	var x = rng.randi_range(50, 2450)
	var y = rng.randi_range(50, 1225)
	if !tryFit(x,y,enemy):
		return getAllowRandomSpawnPosition(enemy)
	return Vector2(x,y)

func tryFit(x,y,Enemy):
		
	var blockedAreas =	[]
	
	for i in range(0,Global.Game.get_node("Zones/BockedAreas").get_child_count(),1):
		blockedAreas.append(Global.Game.get_node("Zones/BockedAreas").get_child(i))
		
	blockedAreas.append(Global.Game.get_node("Zones/Center/CenterArea/CollisionShape2D"))
		
	var TryPosition = Vector2(x,y)
	
	if (!Global.areaBoxCollision(self,TryPosition,Enemy.get_node("Area2D"),blockedAreas)):
		return true
	else:
		return false

func waveTimer(waveChild):
	if (wave!=waveChild.wave):
		return
	if (mining):
		timer=int((mining_max_duration_frames-waveChild.miningFrame)/60)
		waveChild.miningFrame+=1
		if (waveChild.miningFrame==mining_max_duration_frames):
			battleStart()
	else:
		waveChild.waveBehavior()
		timer=int((waveChild.battle_max_duration_frames-waveChild.battleFrame)/60)
		waveChild.battleFrame+=1
		if (waveChild.battleFrame>=waveChild.battle_max_duration_frames):
			battleEnd()
			if (wave<maxWave):
				wave+=1
			else:
				wave=1
			
			waveChild.miningFrame=0
			waveChild.battleFrame=0	
			
			return
