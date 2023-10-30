extends Node2D

var quality="common"

var skeletonDamage = 50
var skeletonQuantity=15

#Duracao em segundos
var cd = 5

var frame=0
var max_duration = 15

var enableCerberus=true
var cerberisDamage = 5
var Allycerberus


func _ready():
	$Sprite2D.modulate.a=0
	Global.timerCreator("destroy", max_duration,[],self)
	$Music.play(10)
	qualityStatus()
	if (enableCerberus):
		creatCerberus()

func qualityStatus():
	#Cooldown: 60/20/5/5/5s Max activations per wave 1/2/2/3/4
	if ( quality=="common"):
		skeletonDamage=500
		skeletonQuantity=15
		cd=5
	
func creatCerberus():
	var cerberus=PreLoads.hades_cerberus.instantiate()
	cerberus.damage=skeletonDamage
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
	skeleton.damage=skeletonDamage
	skeleton.cerberus=Allycerberus
	if (Global.WaveController.mining):
		return
	Global.Game.get_node("Allies").add_child(skeleton)
	skeleton.global_position=Global.player.global_position
