extends Node2D
var reverse =false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(0,get_node("Videos").get_child_count(),1):
		var video = get_node("Videos").get_child(i)
		if (!video.is_playing()):
			video.play()
	
	if (!reverse):
		$Label.modulate.a -= 0.01
		if ($Label.modulate.a<=0.0):
			reverse=true
	else:
		$Label.modulate.a += 0.01
		if ($Label.modulate.a>=1):
			reverse=false

	if Input.is_action_just_pressed("Select"):
		get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn")
