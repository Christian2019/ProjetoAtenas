extends Node2D

func _ready():
	global_position=Global.player.global_position

func _process(delta):
	
	if $AnimatedSprite2D.frame==$AnimatedSprite2D.sprite_frames.get_frame_count("default")-1:
		$AnimatedSprite2D.visible=false
		
	if !$AnimatedSprite2D.visible and !$AudioStreamPlayer.is_playing():
		queue_free()
