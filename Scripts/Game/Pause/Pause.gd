extends Node2D

var pauseActive=false

func _ready():
	Global.Pause=self
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	$OptionsMenu/MasterAudio.value=OptionsController.MasterVolume
	$OptionsMenu/FullScreen.button_pressed= OptionsController.Fullscreen
	$OptionsMenu/Resolutions.selected=OptionsController.Resolution_selected

func _process(delta):
	if pauseActive and !visible:
		get_tree().paused = true
		visible=true
		$Pause/Continue.grab_focus()
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


func _on_continue_pressed():
	pauseActive=false

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")

func _on_options_pressed():
	$OptionsMenu.visible=true
	$Pause.visible=false
	$OptionsMenu/MasterAudio.grab_focus()


func _on_back_pressed():
	$OptionsMenu.visible=false
	$Pause.visible=true
	$Pause/Options.grab_focus()

func _on_master_audio_focus_entered():
	if(Input.is_action_pressed("Move_Left")):
		$OptionsMenu/MasterAudio.value-=1
	elif(Input.is_action_pressed("Move_Right")):
		$OptionsMenu/MasterAudio.value+=1

func _on_resolutions_item_selected(index): 
	var resolutionArray = $OptionsMenu/Resolutions.text.split("x")
	OptionsController.Resolution = Vector2(float(resolutionArray[0]),float(resolutionArray[1]))
	get_window().size=OptionsController.Resolution
	OptionsController.Resolution_selected=index

func _on_full_screen_toggled(button_pressed):
	if(button_pressed == false):
		get_window().mode=Window.MODE_WINDOWED 
		get_node("OptionsMenu/Resolutions").disabled=false
		OptionsController.Fullscreen=false
	else:
		get_window().mode = Window.MODE_FULLSCREEN
		get_node("OptionsMenu/Resolutions").disabled=true
		OptionsController.Fullscreen=true

