extends Node2D

var activate=false

var rng


func _ready():
	rng=RandomNumberGenerator.new()

func _process(delta):
	if (Global.player.dash.skill==PreLoads.warrior_dash_poseidon and !activate):
		activate=true
	elif(Global.player.dash.skill!=PreLoads.warrior_dash_poseidon and activate):
		activate=false

func effect():
	if (activate):
		var r = rng.randi_range(0, 100)
		var quality=Global.player.dash.quality
		var breakPoint
		
		if ( quality=="common"):
			breakPoint=1
		elif ( quality=="rare"):
			breakPoint=2
		elif ( quality=="epic"):
			breakPoint=4
		elif ( quality=="legendary"):
			breakPoint=10
		elif (quality=="divine"):
			breakPoint=20
			
		if (r<=breakPoint):
			Global.player.baseDamage+=1
			Global.timerCreator("removeBD",5,[],self)
		

func removeBD():
	Global.player.baseDamage-=1
