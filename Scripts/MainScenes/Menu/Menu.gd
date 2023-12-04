extends Node2D
var reverse =false

var animacaoStart
var animacaoOptions
var animacaoExit

var fullscreen


func _ready():
	get_tree().paused=false
	animacaoStart = get_node("MenuInicial/Animations/StartButtonAnimations")
	animacaoOptions = get_node("MenuInicial/Animations/OptionsButtonsAnimations")
	animacaoExit = get_node("MenuInicial/Animations/ExitButtonAnimations")  
	$MenuInicial/StartButton.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	$MenuInicial/Musica.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	
	#for i in range(0,get_node("Videos").get_child_count(),1):
		#var video = get_node("Videos").get_child(i)
	#	if (!video.is_playing()): 
		#	video.play() 
				
		#Anterior
		#if (!reverse):
		#	$Label.modulate.a -= 0.01
		#	if ($Label.modulate.a<=0.0):
		#		reverse=true
		#else:
		#	$Label.modulate.a += 0.01
		#	if ($Label.modulate.a>=1):
		#		reverse=false
	if($OptionsMenu.visible==true):  
		OptionsController.MasterVolume = $OptionsMenu/MasterAudio.value 
		
	#if Input.is_action_just_pressed("Select"):
		#get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn")




func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn") 
	#get_tree().change_scene_to_file("res://Scenes/MainScenes/Fatality.tscn")

	
func _on_options_pressed():
	animacaoOptions.play("SlideOut")
	get_node("MenuInicial").visible=false
	get_node("OptionsMenu").visible=true  
	if(get_node("OptionsMenu").visible):
		$OptionsMenu/MasterAudio.grab_focus()

 
func _on_exit_game_pressed():
	get_tree().quit()

	
func _on_back_pressed():
	get_node("MenuInicial").visible=true
	get_node("OptionsMenu").visible=false
	if(get_node("MenuInicial").visible):
		$MenuInicial/Options.grab_focus()

 
func _on_full_screen_toggled(button_pressed):
	if(button_pressed == false):
		get_window().mode=Window.MODE_WINDOWED 
		get_node("OptionsMenu/Resolutions").disabled=false
		OptionsController.Fullscreen=false
	else:
		get_window().mode = Window.MODE_FULLSCREEN
		get_node("OptionsMenu/Resolutions").disabled=true
		OptionsController.Fullscreen=true



func _on_resolutions_item_selected(index): 
	var resolutionArray = $OptionsMenu/Resolutions.text.split("x")
	OptionsController.Resolution = Vector2(float(resolutionArray[0]),float(resolutionArray[1]))
	get_window().size=OptionsController.Resolution
	OptionsController.Resolution_selected=index
	print(index)



#START BUTTON
func _on_start_button_focus_entered():
	animacaoStart.play("SlideIn")



func _on_start_button_focus_exited():
	animacaoStart.play("SlideOut")


func _on_start_button_mouse_entered():
	animacaoStart.play("SlideIn")

 
func _on_start_button_mouse_exited():
	animacaoStart.play("SlideOut")
 

#OPTIONS BUTTON
func _on_options_mouse_entered():
	animacaoOptions.play("SlideIn")


func _on_options_mouse_exited():
	animacaoOptions.play("SlideOut")


func _on_options_focus_entered():
	animacaoOptions.play("SlideIn")


func _on_options_focus_exited():
	animacaoOptions.play("SlideOut")



#EXIT BUTTON
func _on_exit_game_focus_entered():
	animacaoExit.play("SlideIn")



func _on_exit_game_focus_exited():
	animacaoExit.play("SlideOut")


func _on_exit_game_mouse_entered():
	animacaoExit.play("SlideIn")

 
func _on_exit_game_mouse_exited():
	animacaoExit.play("SlideOut")



func _on_master_audio_focus_entered():
	if(Input.is_action_pressed("Move_Left")):
		$OptionsMenu/MasterAudio.value-=1
	elif(Input.is_action_pressed("Move_Right")):
		$OptionsMenu/MasterAudio.value+=1



func _on_video_stream_player_finished():
	$Videos/VideoStreamPlayer.play()
