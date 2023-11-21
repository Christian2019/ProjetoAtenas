extends Node2D

var basic_radios

var moving = false

var speed = 6

var endTurn = false

func _ready():
	basic_radios = Global.player.collect_radios

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
		if (!endTurn):				
			if (area.get_parent().dracmaBag>0):
				area.get_parent().dracmaBag-=1
				area.get_parent().dracma+=2
				Global.LevelUp.levelExperience+=2
			else:
				area.get_parent().dracma+=1
				Global.LevelUp.levelExperience+=1
		else:
			area.get_parent().dracmaBag+=1
		playSound()
		queue_free()

func playSound():
	for i in range(0, Global.Game.get_node("SoundController/Dracma").get_child_count(),1):
		var sound = Global.Game.get_node("SoundController/Dracma").	get_child(i)
		if (!sound.playing):
			sound.play()
			return
