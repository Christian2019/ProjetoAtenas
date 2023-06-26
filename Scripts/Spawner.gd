extends Node2D

@export_enum("S", "E","W") var direction_move: String = "S"

@export_enum("Minotaur") var enemy_type: String = "Minotaur"

@export var enable : bool = true

#timerCreator(functionName,time,parameters,node): paramenters: []

var wave_timer = 60
var enemies_interval_spawn = 1.5
var enemies_quantity = 5

var transitionPositionRng=50

func _ready():
	visible=false

var start_bool = true
func start():
	if (start_bool):
		start_bool=false
		createWave()

func _process(delta):
	if (!enable):
		return
	start()
	
	
func createWave():
	Global.timerCreator("createWave",wave_timer,[],self)
	for i in range(0,enemies_quantity,1):
		if (i==0):
			createEnemy()
		else:
			Global.timerCreator("createEnemy",enemies_interval_spawn*i,[],self)

func createEnemy():
	if (enemy_type=="Minotaur"):
		spawnEnemy(PreLoadeds.minotaur.instantiate())

func spawnEnemy(enemy):
	enemy.direction = direction_move
	enemy.global_position = global_position
	enemy.name = str(enemy_type,name)
	var rng = RandomNumberGenerator.new()
	var rngPosition_change = rng.randi_range(0, transitionPositionRng*2)
	if (direction_move=="S"):
		enemy.global_position.x = enemy.global_position.x-transitionPositionRng+rngPosition_change
	else:
		enemy.global_position.y = enemy.global_position.y-transitionPositionRng+rngPosition_change
	
	get_parent().get_parent().get_node("Enemies").call_deferred("add_child",enemy)
