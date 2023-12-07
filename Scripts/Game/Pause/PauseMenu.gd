extends Node2D

var gamePaused=false
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	Global.PauseMenu=self
	#MasterAudio
	$OptionsMenu/MasterAudio.value=OptionsController.MasterVolume
	$OptionsMenu/FullScreen.button_pressed= OptionsController.Fullscreen
	$OptionsMenu/Resolutions.selected=OptionsController.Resolution_selected
	pass # Replace with function body.
 
func _process(delta):
	#Verificando se o jogo está pausado
	if Input.is_action_just_pressed("Pause") and gamePaused==false: 
		get_tree().paused = true  
		visible=true
		gamePaused=true
		$Pause/Continue.grab_focus()  
	elif Input.is_action_just_pressed("Pause") and gamePaused==true: 
		get_tree().paused=false
		$OptionsMenu.visible=false
		$Pause.visible=true
		visible=false 
		gamePaused=false
		
	if($OptionsMenu.visible==true):  
		OptionsController.MasterVolume = $OptionsMenu/MasterAudio.value 
		if($OptionsMenu/FullScreen.button_pressed):
			$OptionsMenu/Resolutions.disabled=true
		else:
			$OptionsMenu/Resolutions.disabled=false
func _on_continue_pressed():
	get_tree().paused = false 
	visible=false
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")
	pass # Replace with function body.


func _on_options_pressed():
	$OptionsMenu.visible=true
	$Pause.visible=false
	$OptionsMenu/MasterAudio.grab_focus()
	pass # Replace with function body.


func _on_back_pressed():
	$OptionsMenu.visible=false
	$Pause.visible=true
	$Pause/Options.grab_focus()
	pass # Replace with function body.


func _on_master_audio_focus_entered():
	if(Input.is_action_pressed("Move_Left")):
		$OptionsMenu/MasterAudio.value-=1
	elif(Input.is_action_pressed("Move_Right")):
		$OptionsMenu/MasterAudio.value+=1
	pass # Replace with function body.

func _on_resolutions_item_selected(index): 
	var resolutionArray = $OptionsMenu/Resolutions.text.split("x")
	OptionsController.Resolution = Vector2(float(resolutionArray[0]),float(resolutionArray[1]))
	get_window().size=OptionsController.Resolution
	OptionsController.Resolution_selected=index
	pass # Replace with function body.


func _on_full_screen_toggled(button_pressed):
	if(button_pressed == false):
		get_window().mode=Window.MODE_WINDOWED 
		get_node("OptionsMenu/Resolutions").disabled=false
		OptionsController.Fullscreen=false
	else:
		get_window().mode = Window.MODE_FULLSCREEN
		get_node("OptionsMenu/Resolutions").disabled=true
		OptionsController.Fullscreen=true
	pass # Replace with function body.  
