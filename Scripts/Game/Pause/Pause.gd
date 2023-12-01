extends Node2D

var pauseActive=false

func _ready():
	Global.Pause=self
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if pauseActive and !visible:
		get_tree().paused = true
		visible=true
	elif !pauseActive and visible:
		get_tree().paused = false
		visible=false
	elif visible:
		if Input.is_action_just_pressed("Pause"):
			pauseActive=false
		elif Input.is_action_just_pressed("Move_Left"):
			$ItensHud/ItemHUD.select=true
			$ItensHud/Selected.visible=true
		elif Input.is_action_just_pressed("Move_Right"):
			$ItensHud/ItemHUD.select=false
			$ItensHud/Selected.visible=false
