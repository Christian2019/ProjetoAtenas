extends Node2D
var reverse =false

var animacaoStart
var animacaoOptions
var animacaoExit

var fullscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	animacaoStart = get_node("MenuInicial/Animations/StartButtonAnimations")
	animacaoOptions = get_node("MenuInicial/Animations/OptionsButtonsAnimations")
	animacaoExit = get_node("MenuInicial/Animations/ExitButtonAnimations")
	OptionsController.MusicVolume = $MenuInicial/Musica.volume_db
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	$MenuInicial/Musica.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	if($MenuInicial.visible==true):
		for i in range(0,get_node("MenuInicial/Videos").get_child_count(),1):
			var video = get_node("MenuInicial/Videos").get_child(i)
			if (!video.is_playing()):
				video.play() 
		#if (!reverse):
		#	$Label.modulate.a -= 0.01
		#	if ($Label.modulate.a<=0.0):
		#		reverse=true
		#else:
		#	$Label.modulate.a += 0.01
		#	if ($Label.modulate.a>=1):
		#		reverse=false
	elif($OptionsMenu.visible==true):  
		OptionsController.MasterVolume = $OptionsMenu/MasterAudio.value
		OptionsController.MusicVolume = $OptionsMenu/MusicAudio.value
		if($OptionsMenu/FullScreen.button_pressed==false):
			OptionsController.Fullscreen=false
		else:
			OptionsController.Fullscreen=true
			
		var resolutionArray = $OptionsMenu/Resolutions.text.split("x")
		OptionsController.Resolution = Vector2(float(resolutionArray[0]),float(resolutionArray[1]))
		
	#if Input.is_action_just_pressed("Select"):
		#get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn")

func _on_start_button_mouse_entered():
	animacaoStart.play("SlideIn")
	pass # Replace with function body.
 
func _on_start_button_mouse_exited():
	animacaoStart.play("SlideOut")
	pass # Replace with function body.  

func _on_options_mouse_entered():
	animacaoOptions.play("SlideIn")
	pass # Replace with function body. 

func _on_options_mouse_exited():
	animacaoOptions.play("SlideOut")
	pass # Replace with function body. 

func _on_exit_game_mouse_entered():
	animacaoExit.play("SlideIn")
	pass # Replace with function body.
 
func _on_exit_game_mouse_exited():
	animacaoExit.play("SlideOut")
	pass # Replace with function body.


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Loading.tscn") 
	#get_tree().change_scene_to_file("res://Scenes/MainScenes/Fatality.tscn")
	pass # Replace with function body.
	
func _on_options_pressed():
	animacaoOptions.play("SlideOut")
	get_node("MenuInicial").visible=false
	get_node("OptionsMenu").visible=true
	pass # Replace with function body.


func _on_exit_game_pressed():
	get_tree().quit()
	pass # Replace with function body.
	
func _on_back_pressed():
	get_node("MenuInicial").visible=true
	get_node("OptionsMenu").visible=false
	pass # Replace with function body.
