extends Node2D

var verticalSpeed=-4
var duration =1
var crit=false
var damage

func _ready():
	
	Global.timerCreator("queue_free",duration,[],self)
	$Label.text=str(damage)
	$Label.set("theme_override_colors/font_color", Color8(10, 90, 0)
)
	if (crit):
		$Label.scale*=1.5
		$Label.set("theme_override_colors/font_color", Color8(255, 0, 0))

func _process(delta):
	global_position+=Vector2(0,verticalSpeed)
