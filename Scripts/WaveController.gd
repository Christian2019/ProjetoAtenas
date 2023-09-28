extends Node2D

var startTimer = 5
var timer = startTimer

var battleTimer = startTimer/2

var battleTime=false

var soundController
var enemies

func _ready():
	soundController= get_parent().get_node("SoundController")
	enemies = get_parent().get_node("Enemies")
	passTime()


func _process(_delta):
	if (battleTime and timer ==0 and enemies.get_child_count()==0):
		battleEnd()	



func passTime():
	timer-=1
	if timer==0:
		if (!battleTime):
			battleStart()
	else:
		Global.timerCreator("passTime",1,[],self)

func battleStart():
	battleTime=true
	timer = battleTimer
	soundController.startBattleMusic()
	passTime()
	createEnemies()


	
func battleEnd():
	battleTime=false
	timer = startTimer
	soundController.endBattleMusic()
	passTime()

func createEnemies():
	if (battleTime and timer>0):
		spawnEnemy(PreLoads.minotaur.instantiate())
		Global.timerCreator("createEnemies",1,[],self)
		
func spawnEnemy(enemy):
	enemy.position = getAllowRandomSpawnPosition()
	enemy.name = "Minotaur"
	get_parent().get_node("Enemies").call_deferred("add_child",enemy)

func getAllowRandomSpawnPosition():
	var rng = RandomNumberGenerator.new()
	var x = rng.randi_range(0, 2500)
	var y = rng.randi_range(0, 1275)
	if (x>1174 and x<1428 and y>483 and y<734):
		getAllowRandomSpawnPosition()
	return Vector2(x,y)

	
