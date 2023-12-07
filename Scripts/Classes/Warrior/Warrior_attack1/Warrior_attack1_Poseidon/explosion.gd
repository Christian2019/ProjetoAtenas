extends Node2D
var speedScale=0.2
func _ready():
	global_position=Global.player.global_position
	$Sprite2D.scale=Vector2(0,0)

func _process(delta):
	$Sprite2D.scale+=Vector2(speedScale,speedScale)
	if $Sprite2D.scale.x>10:
		queue_free()
