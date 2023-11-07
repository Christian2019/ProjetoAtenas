extends Node2D

var playing = false
var rng = RandomNumberGenerator.new()
var playerMute=false
var soundsPosition=[]
var musicSelected=0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	$AudioStreamPlayer.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	$AudioStreamPlayer2.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	$AudioStreamPlayer3.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	for i in range(0,get_child_count(),1):
		soundsPosition.append(0.0)

func _process(delta):
	if (Global.TempleScreen.visible and !playing and !playerMute):
		rngMusic()
		enableSound()
	
	elif (!Global.TempleScreen.visible and playing):
		disableSound()
	
	elif (Global.TempleScreen.visible and Input.is_action_just_pressed("Mute")):
		if (playing):
			playerMute=true
			disableSound()
		else:
			playerMute=false
			enableSound()

func rngMusic():
	musicSelected = rng.randi_range(0, get_child_count()-1)


func enableSound():
	playing = true
	get_child(musicSelected).play(soundsPosition[musicSelected])

	
func disableSound():
	playing = false
	soundsPosition[musicSelected]=get_child(musicSelected).get_playback_position()
	get_child(musicSelected).playing=false
