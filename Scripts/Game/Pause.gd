extends Node2D

func _ready():
	Global.Pause=self
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta):
	if visible and !get_tree().paused:
		get_tree().paused = true
	elif !visible and get_tree().paused:
		get_tree().paused = false
	elif visible:
		if Input.is_action_just_pressed("Pause"):
			$ItensHud/ItemHUD.select=false
			$ItensHud/Selected.visible=false
			visible=false
		if Input.is_action_just_pressed("Move_Left"):
			$ItensHud/ItemHUD.select=true
			$ItensHud/Selected.visible=true
		elif Input.is_action_just_pressed("Move_Right"):
			$ItensHud/ItemHUD.select=false
			$ItensHud/Selected.visible=false
