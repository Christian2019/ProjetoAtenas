extends Node2D
var quality
var skillsFinish=0
var cd=20


func _ready():
	createDivineInstance(PreLoads.warrior_ultimate_hades).global_position-=Vector2(0,200)
	Global.timerCreator("createSecondInstance",0.2,[],self)

func createSecondInstance():
	createDivineInstance(PreLoads.warrior_ultimate_poseidon)	
	
func _process(delta):
	if (skillsFinish==2):
		destroy()
	
func destroy():
	Global.hud.max_ultimate_frame=(cd)*60
	Global.timerCreator("enableAttackUse",cd,[4],Global.player)
	Global.Game.get_node("Night").visible=false
	call_deferred("queue_free")
	
	
func createDivineInstance(god):
	var attackInstance = god.instantiate()
	attackInstance.quality= "divine"
	attackInstance.divineReference=self
	Global.Game.get_node("Instances/Ultimates").add_child(attackInstance)
	attackInstance.global_position=	Global.player.global_position
	return attackInstance