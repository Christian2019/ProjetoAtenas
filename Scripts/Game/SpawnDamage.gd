extends Node2D

var verticalSpeed=-5
var duration =1
var crit=false
var colorBlue=false
var miss=false
var lifeSteal=false
var damage

func _ready():
	
	Global.timerCreator("queue_free",duration,[],self)
	if (lifeSteal):
		$Label.text=str(1)
		$Label.set("theme_override_colors/font_color", Color8(0, 247, 0))
		return
	if (miss):
		$Label.text="Miss"
	else:
		$Label.text=str(int(damage))
	
	if (crit):
		$Label.scale*=1.5
		$Label.set("theme_override_colors/font_color", Color8(255, 0, 0))
	elif (colorBlue):
		$Label.set("theme_override_colors/font_color", Color8(76, 76, 204))
	else:
		$Label.set("theme_override_colors/font_color", Color8(10, 90, 0))

	

func _process(delta):
	global_position+=Vector2(0,verticalSpeed)
