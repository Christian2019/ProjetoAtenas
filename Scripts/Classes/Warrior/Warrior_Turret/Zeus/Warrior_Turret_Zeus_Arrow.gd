extends Node2D

var speed=10
var angle
var damage
var maxBounce=0
var bounceCont=0

func _ready():
	rotation_degrees=angle

func _process(delta):
	position.x+=speed*cos(deg_to_rad(angle))
	position.y+=speed*sin(deg_to_rad(angle))


func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		var enemy = area.get_parent()
		Global.MathController.damageController(damage,enemy)
		if (bounceCont<maxBounce):
			bounceCont+=1
			getRandomEnemy()
		else:
			queue_free()
		

func getRandomEnemy():
	var enemies= Global.Game.get_node("Enemies").get_children()
	if (enemies.size()==0):
		queue_free()
		return
	var rng = RandomNumberGenerator.new().randi_range(0, enemies.size()-1)
	angle=rad_to_deg(global_position.angle_to_point(enemies[rng].global_position))
	rotation_degrees=angle
