extends Node2D

var quality="common"

var quantityOfShadows=5

var duration = 0.3
var cd = 1

var speed

var frame=0
var stepFrame

var direction="E"

#GodBonus


func _ready():
	Global.player.dashing=true
	Global.timerCreator("stopDashing",duration,[],self)
	stepFrame=int((duration*60)/(quantityOfShadows+1))
	Global.Game.get_node("SoundController/Dash").play()
	speed=Global.player.move_Speed*2

func stopDashing():
	Global.player.dashing=false
	Global.timerCreator("enableAttackUse",cd,[3],Global.player)
	Global.player.playAnimation ("Idle")
	queue_free()


func _process(delta):
	move()
	if (frame%stepFrame==0):
		createShadow()

	frame+=1

func move():
	var speedModifier=1
	var interrupted=false

	if direction=="NE" or direction=="SE" or direction=="SW" or direction=="NW":
			speedModifier=1/(2**0.5)			
	
	if direction=="S" or direction=="SE" or direction=="SW": 
		interrupted=!Global.player.tryToMove(0,speed*speedModifier)
	elif direction=="N" or direction=="NE" or direction=="NW":
		interrupted=!Global.player.tryToMove(0,speed*speedModifier*(-1))
	if direction=="E" or direction=="SE" or direction=="NE": 
		interrupted=!Global.player.tryToMove(speed*speedModifier,0)
	elif direction=="W" or direction=="SW" or direction=="NW": 
		interrupted=!Global.player.tryToMove(speed*speedModifier*(-1),0)
	
	if (interrupted):
		stopDashing()


func createShadow():
	var dashShadow = PreLoads.dashShadow.instantiate()
	dashShadow.add_child(Global.player.get_node("Animation").duplicate())
	Global.Game.get_node("Instances/Projectiles").add_child(dashShadow)
	dashShadow.global_position=global_position
	dashShadow.scale= Global.player.scale
	dashShadow.duration = int(duration*60)
