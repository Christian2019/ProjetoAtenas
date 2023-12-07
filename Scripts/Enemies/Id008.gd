extends Node2D

var id=8
var maxHp=500
var hp = maxHp
var damages = {}

var speed=0

var dracmas=1

var spawnDelay=5

var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

var attackSpeedModifierVar=[]


func _ready():
	maxHp=maxHp*AllSkillsValues.enemyBaseHpWaveMultiplier**(Global.WaveController.wave-1)
	hp = maxHp
	for i in range(0,damages.values().size(),1):
		damages[damages.keys()[i]]*=AllSkillsValues.enemyBaseDamageWaveMultiplier**(Global.WaveController.wave-1)
	if Global.WaveController.wave>10:
		dracmas=2
		
	maxHpBarWidth=$HPBar/Red.size.x
	Global.timerCreator("spawDragon",spawnDelay,[],self)
	$AnimatedSprite2D2.modulate.a=0

func _process(_delta):
	if (hp<=0):
		hp=0
		die()
		return
	
	hpBarController()

	hatching()

func hatching():
	var aStep= float(1)/float(spawnDelay*60)
	$AnimatedSprite2D2.modulate.a+=aStep

func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth

func die():
	for i in range(0,dracmas,1):
		var dracma = PreLoads.dracma.instantiate()
		dracma.global_position=global_position
		Global.Game.get_node("Instances/Dracmas").add_child(dracma)
		
		
	#Animacao de morte
	call_deferred("queue_free")
	
func spawDragon():
	var dragon = PreLoads.dragon.instantiate()
	Global.Game.get_node("Enemies").add_child(dragon)
	dragon.global_position=global_position
	queue_free()
	
