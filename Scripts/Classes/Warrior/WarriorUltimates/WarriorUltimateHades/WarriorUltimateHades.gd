extends Node2D

var quality

var currentHPPercentDamage
var skeletonQuantity=15

#Duracao em segundos
var cd 

var frame=0
var max_duration = 15

var cerberusDamage
var Allycerberus

var divineReference

func _ready():
	cd= AllSkillsValues.warrior_ultimate_hades_cd
	Global.Game.get_node("Night").visible=true
	$Sprite2D.modulate.a=0
	Global.timerCreator("destroy", max_duration,[],self)
	$Music.play(10)
	qualityStatus()
	
func qualityStatus():
	if ( quality=="common"):
		currentHPPercentDamage=AllSkillsValues.warrior_ultimate_hades_currentHPPercentDamage[0]
		skeletonQuantity=AllSkillsValues.warrior_ultimate_hades_skeletonQuantity[0]
	elif ( quality=="rare"):
		currentHPPercentDamage=AllSkillsValues.warrior_ultimate_hades_currentHPPercentDamage[1]
		skeletonQuantity=AllSkillsValues.warrior_ultimate_hades_skeletonQuantity[1]
	elif ( quality=="epic"):
		currentHPPercentDamage=AllSkillsValues.warrior_ultimate_hades_currentHPPercentDamage[2]
		skeletonQuantity=AllSkillsValues.warrior_ultimate_hades_skeletonQuantity[2]
	elif ( quality=="legendary"):
		cerberusDamage=AllSkillsValues.warrior_ultimate_hades_cerberusDamage
		currentHPPercentDamage=AllSkillsValues.warrior_ultimate_hades_currentHPPercentDamage[3]
		skeletonQuantity=AllSkillsValues.warrior_ultimate_hades_skeletonQuantity[3]
		creatCerberus()
	elif ( quality=="divine"):
		cerberusDamage=AllSkillsValues.warrior_ultimate_divine_hades_cerberusDamage
		currentHPPercentDamage=AllSkillsValues.warrior_ultimate_divine_hades_currentHPPercentDamage
		skeletonQuantity=AllSkillsValues.warrior_ultimate_divine_hades_skeletonQuantity
		creatCerberus()

func creatCerberus():
	var cerberus=PreLoads.hades_cerberus.instantiate()
	cerberus.damage=cerberusDamage
	cerberus.ultimate=self
	if (Global.WaveController.mining):
		return
	Global.Game.get_node("Allies").add_child(cerberus)
	cerberus.global_position=Global.player.global_position
	Allycerberus=cerberus

func destroy():
	if (quality=="divine"):
		if is_instance_valid(divineReference):
			divineReference.skillsFinish+=1
	else:
		Global.hud.max_ultimate_frame=(cd)*60
		Global.timerCreator("enableAttackUse",cd,[4],Global.player)
		Global.Game.get_node("Night").visible=false
	queue_free()

func _process(delta):

	if (Global.player.playerOnCenterPoint or Global.Game.get_node("WaveController").mining):
		destroy()
	$Sprite2D.modulate.a=float(frame)/float(max_duration*60)
	skeletonCreation()
	frame+=1


func skeletonCreation():
	var step= int(float(max_duration*60)/float(skeletonQuantity))
	if (frame%step==0):
		spawn()
		
func spawn():
	var skeleton=PreLoads.hades_skeleton.instantiate()
	skeleton.damage=Global.player.hp*currentHPPercentDamage
	skeleton.cerberus=Allycerberus
	if (Global.WaveController.mining):
		return
	Global.Game.get_node("Allies").add_child(skeleton)
	skeleton.global_position=Global.player.global_position
