extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.frame==$AnimatedSprite2D.sprite_frames.get_frame_count("default")-1:
		$AnimatedSprite2D.visible=false
		
	if !$AnimatedSprite2D.visible and !$AudioStreamPlayer.is_playing():
		queue_free()
