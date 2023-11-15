extends Node2D

var quality

var currentHPPercentDamage
var skeletonQuantity=15

#Duracao em segundos
var cd = 20

var frame=0
var max_duration = 15

var cerberusDamage
var Allycerberus

func _ready():
	Global.Game.get_node("Night").visible=true
	$Sprite2D.modulate.a=0
	Global.timerCreator("destroy", max_duration,[],self)
	$Music.play(10)
	qualityStatus()
	
func qualityStatus():
	if ( quality=="common"):
		currentHPPercentDamage=0.1
		skeletonQuantity=15
	elif ( quality=="rare"):
		currentHPPercentDamage=0.15
		skeletonQuantity=30
	elif ( quality=="epic"):
		currentHPPercentDamage=0.2
		skeletonQuantity=45
	elif ( quality=="legendary"):
		cerberusDamage=1500
		currentHPPercentDamage=0.3
		skeletonQuantity=60
		creatCerberus()
	elif ( quality=="divine"):
		cerberusDamage=3000
		currentHPPercentDamage=0.5
		skeletonQuantity=90
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
