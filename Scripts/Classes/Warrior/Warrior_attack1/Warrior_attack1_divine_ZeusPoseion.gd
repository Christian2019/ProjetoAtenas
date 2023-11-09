extends Node2D
var direction
var quality
var skillsFinish=0
var canFinish=true

func _ready():
	createDivineInstance(PreLoads.warrior_attack1_zeus)
	Global.timerCreator("createSecondInstance",0.2,[],self)

func createSecondInstance():
	createDivineInstance(PreLoads.warrior_attack1_poseidon)	
	
func _process(delta):
	if (skillsFinish==2):
		destroy()
	
func destroy():
	if canFinish:
		Global.player.permissions[0]=true
	call_deferred("queue_free")
	
	
func createDivineInstance(god):
	var attackInstance = god.instantiate()
	attackInstance.quality= "divine"
	attackInstance.direction=direction
	Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
	attackInstance.global_position=global_position
	attackInstance.divineReference=self

