extends Node2D
var direction
var quality
var skillsFinish=0
var s1
var s2

func _ready():
	createDivineInstance(PreLoads.warrior_attack1_zeus)
	#Global.tim
	createDivineInstance(PreLoads.warrior_attack1_poseidon)
	
func _process(delta):
	if (skillsFinish==2):
		destroy()
	
func destroy():
	Global.player.permissions[0]=true
	call_deferred("queue_free")
	
	
func createDivineInstance(god):
	var attackInstance = god.instantiate()
	attackInstance.quality= "divine"
	Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
	attackInstance.global_position=global_position
	attackInstance.direction=direction
	attackInstance.divineReference=self

