extends Node2D



func _ready():
	Global.timerCreator("disableEnableVisibility",0.3,[],self)

func disableEnableVisibility():
	if (visible):
		Global.timerCreator("disableEnableVisibility",0.1,[],self)
	else:
		Global.timerCreator("disableEnableVisibility",0.3,[],self)
	visible=!visible

func useSpriteBlue():
	$Sprite2D.visible=false
	$Sprite2D2.visible=true
