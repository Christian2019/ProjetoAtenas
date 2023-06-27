extends Node2D

var target

var moveLocation

var speed = 3

var liveTime=5

var canKill=true

func _ready():
	Global.timerCreator("call_deferred",liveTime,["free"],self)

func _process(delta):
	if (target!=null):
		moveLocation = Vector2(target.position.x,target.position.y)
	move()
	
	
	
func move():
	if (moveLocation==null):
		visible=false
		canKill=false
		return
		
	if (position.distance_to(moveLocation)>speed):
		var dx = speed*cos(get_angle_to(moveLocation))
		var dy = speed*sin(get_angle_to(moveLocation))
		position+=Vector2(dx,dy)
	else:
		canKill=false
	
func hit(enemy):
	if (enemy!=null):
		enemy.call_deferred("free")
	visible=false

func _on_area_2d_area_entered(area):
	if (!canKill):
		return
		
	if 	(area.get_parent().get_parent().name=="Enemies"):
		canKill=false
		
		if (target!=null and area.get_parent().name==target.name):
			Global.timerCreator("hit",0.2,[area.get_parent()],self)
		else:
			hit(area.get_parent())
		
		
