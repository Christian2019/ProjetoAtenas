extends Node2D

var basic_radios = 100 

var moving = false

var speed = 6

var endTurn = false

func _ready():
	var rng = RandomNumberGenerator.new().randi_range(0, 209)
	$Itens.frame=rng 

func _process(delta):
	if (Global.Game.get_node("WaveController").mining):
		endTurn=true
		moving=true
		
	if (!moving):
		if (global_position.distance_to(Global.player.global_position)<basic_radios):
			moving=true
	if (moving):
		global_position+= Vector2(speed*cos(global_position.angle_to_point(Global.player.global_position)),speed*sin(global_position.angle_to_point(Global.player.global_position)))


func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		playSound()
		queue_free()

func playSound():
	for i in range(0, Global.Game.get_node("SoundController/Dracma").get_child_count(),1):
		var sound = Global.Game.get_node("SoundController/Dracma").	get_child(i)
		if (!sound.playing):
			sound.play()
			return
