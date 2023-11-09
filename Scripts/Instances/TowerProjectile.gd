extends Node2D

var target

var moveLocation

var speed = 3

var liveTime=5

var damage = 1

var canDamage = true

func _ready():
	Global.timerCreator("call_deferred",liveTime,["free"],self)

func _process(_delta):
	if (target!=null):
		moveLocation = Vector2(target.position.x,target.position.y)
	move()
	
	
	
func move():
	if (moveLocation==null):
		visible=false
		canDamage=false
		return
		
	if (position.distance_to(moveLocation)>speed):
		var dx = speed*cos(get_angle_to(moveLocation))
		var dy = speed*sin(get_angle_to(moveLocation))
		position+=Vector2(dx,dy)
	else:
		canDamage=false
	
func hit(enemy):
	if (enemy!=null):
		enemy.hp-=damage
	visible=false

func _on_area_2d_area_entered(area):
	if (!canDamage):
		return
		
	if 	(area.get_parent().get_parent().name=="Enemies"):
		canDamage=false
		
		if (target!=null and area.get_parent().name==target.name):
			Global.timerCreator("hit",0.2,[area.get_parent()],self)
		else:
			hit(area.get_parent())
		
		
