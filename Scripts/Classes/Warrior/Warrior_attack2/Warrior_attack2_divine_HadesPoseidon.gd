extends Node2D
var direction
var quality
var skillsFinish=0


func _ready():
	createDivineInstance(PreLoads.warrior_attack2_hades)
	Global.timerCreator("createSecondInstance",0.2,[],self)

func createSecondInstance():
	createDivineInstance(PreLoads.warrior_attack2_poseidon)	
	
func _process(delta):
	if (skillsFinish==2):
		destroy()
	
func destroy():
	Global.player.permissions[1]=true
	call_deferred("queue_free")
	
	
func createDivineInstance(god):
	var attackInstance = god.instantiate()
	attackInstance.quality= "divine"
	Global.Game.get_node("Instances/Projectiles").add_child(attackInstance)
	attackInstance.global_position=global_position
	attackInstance.divineReference=self

