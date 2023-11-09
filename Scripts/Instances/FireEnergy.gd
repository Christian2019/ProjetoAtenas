extends Node2D

var type
var speed
var damage
var angle
var boss
var startDistanceFromBoss

#t01
var target
var delay
var attacking=false

func _ready():
	if type==1:
		global_position=target
		$Pretarget.visible=true
		$AnimatedSprite2D.visible=false
		modulate.a=0.5
		Global.timerCreator("enableAttack",delay,[],self)


func _process(delta):
	if (bossIsDead()):
		queue_free()
		return
		
	if (type==0):
		type0()
	if (type==1):
		type1()
		
	if (global_position.y>1225):
		visible=false
	elif !visible:
		visible=true

func bossIsDead():
	if is_instance_valid(boss) and !boss.is_queued_for_deletion():
		return false
	return true		

func type0():
	speed=boss.t0Speed
	angle+=speed
	var relativePosition= Vector2(0,0)
	relativePosition.y=startDistanceFromBoss*cos(deg_to_rad(angle))
	relativePosition.x=startDistanceFromBoss*sin(deg_to_rad(angle))
	$AnimatedSprite2D.rotation=deg_to_rad(-angle)
	global_position= boss.global_position+relativePosition

func type1():
	if (attacking):
		var moveAngle= global_position.angle_to_point(target)
		if (global_position.distance_to(target)<speed):
			queue_free()
			return
		
		global_position.x+=speed*cos(moveAngle)
		global_position.y+=speed*sin(moveAngle)
	

func enableAttack():
	attacking=true
	global_position=boss.global_position
	$Pretarget.visible=false
	$AnimatedSprite2D.visible=true
	modulate.a=1

func _on_area_2d_area_entered(area):
	if (!attacking):
		return
	if (area.get_parent().name=="Player" or area.get_parent().name=="Center"):
		var enemy = area.get_parent()
		Global.MathController.damageController(damage,enemy)
		enemy.activateFeedback()
		if (type!=0):
			queue_free()
	if (area.name=="BockedAreas"):
		if (type!=0):
			queue_free()

