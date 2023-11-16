extends Node2D

var speed=10
var angle
var damage
var pierceCont=0
var pierce=0
var waterDamage=0

func _ready():
	rotation_degrees=angle

func _process(delta):
	position.x+=speed*cos(deg_to_rad(angle))
	position.y+=speed*sin(deg_to_rad(angle))


func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		var enemy = area.get_parent()
		
		if (waterDamage>0):
			Global.MathController.attack1_poseidon.addEntityWaterDamage(enemy,waterDamage)
		
		Global.MathController.damageController(damage,enemy)
	
		if (pierceCont<pierce):
			pierceCont+=1
		else:
			queue_free()
	

