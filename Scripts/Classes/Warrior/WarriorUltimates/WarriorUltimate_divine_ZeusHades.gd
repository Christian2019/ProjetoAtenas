extends Node2D
var quality
var skillsFinish=0
var cd


func _ready():
	cd=int((AllSkillsValues.warrior_ultimate_hades_cd+AllSkillsValues.warrior_ultimate_zeus_cd)/2)
	createDivineInstance(PreLoads.warrior_ultimate_zeus)
	Global.timerCreator("createSecondInstance",0.2,[],self)

func createSecondInstance():
	createDivineInstance(PreLoads.warrior_ultimate_hades)	
	
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
	Global.Game.get_node("Instances/Ultimates").add_child(attackInstance)
	attackInstance.global_position=global_position
	attackInstance.divineReference=self

