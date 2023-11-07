extends Node2D


func _ready():
	Global.Game = self
	$SoundController/AOEMusic.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	$SoundController/EliteMusic.volume_db = OptionsController.MasterVolume + OptionsController.MusicVolume
	$SoundController/Dash.volume_db = OptionsController.MasterVolume
	$SoundController/Dracma/Sound.volume_db = OptionsController.MasterVolume
	$SoundController/Dracma/Sound2.volume_db = OptionsController.MasterVolume
	$SoundController/Dracma/Sound3.volume_db = OptionsController.MasterVolume
	$SoundController/Dracma/Sound4.volume_db = OptionsController.MasterVolume
func _process(_delta):

	if (Input.is_action_just_pressed("zoomOut")):
		Global.camera.zoom.x=0.5
		Global.camera.zoom.y=0.5

	if (Input.is_action_just_pressed("zoomIn")):
		Global.camera.zoom.x=0.75
		Global.camera.zoom.y=0.75
		
	if (Input.is_action_just_pressed("IncresseWave")):
		if (Global.WaveController.wave+1>Global.WaveController.maxWave):
			Global.WaveController.wave=1
		else:
			Global.WaveController.wave+=1	
	elif (Input.is_action_just_pressed("DecressWave")):
		if (Global.WaveController.wave>1):
			Global.WaveController.wave-=1
	
	changeSkills()
var selected=0
var s0=0
var q0=0
var s1=0
var q1=0
var s2=0
var q2=0
var s3=0
var q3=0
var s4=0
var q4=0
	
var changePlayerSkill=false

func changeSkills():
	if (Input.is_action_just_pressed("ChangeSkillSelected")):
		selected+=1
		if (selected>4):
			selected=0
		Global.hud.get_node("Frontground/Skills/Selected/Label").text=str(selected)
		
	elif (Input.is_action_just_pressed("ChangeSkillGod")):
		changeSkillGod()
		
	elif (Input.is_action_just_pressed("ChangeSkillQuality")):
		ChangeSkillQuality()
	
	if (changePlayerSkill):
		changePlayerSkillFunction()

func changePlayerSkillFunction():
	changePlayerSkill=false
	var skill=getSkill()
	var quality=getQuality()

			
	if (skill!=null):
		if (selected==0):
			Global.player.attack1={"skill":skill, "quality": quality}
			
	
func getSkill():
	if selected==0:
		if s0==0:
			return PreLoads.warrior_attack1_noGod
		elif s0==1:
			return PreLoads.warrior_attack1_zeus
		elif s0==3:
			return PreLoads.warrior_attack1_poseidon
	
	return null
	
func getQuality():
	var q
	if (selected==0):
		q=q0
	elif (selected==1):
		q=q1
	elif (selected==2):
		q=q2
	elif (selected==3):
		q=q3
	elif (selected==4):
		q=q4
		
	if (q==0):
		return "common"
	elif (q==1):
		return "rare"
	elif (q==2):
		return "epic"
	elif (q==3):
		return "legendary"

func changeSkillGod():
		if (selected==0):
			s0+=1
			if (s0>3):
				s0=0
			Global.hud.get_node("Frontground/Skills/Attack1_Border/Attack1").frame=s0
			
		elif (selected==1):
			s1+=1
			if (s1>3):
				s1=0
			Global.hud.get_node("Frontground/Skills/Attack2_Border/Attack2").frame=s1
			
		elif (selected==2):
			s2+=1
			if (s2>2):
				s2=0
			Global.hud.get_node("Frontground/Skills/Turret/Turret").frame=s2
			
		elif (selected==3):
			s3+=1
			if (s3>3):
				s3=0
			Global.hud.get_node("Frontground/Skills/Dash/Dash").frame=s3
			
		elif (selected==4):
			s4+=1
			if (s4>2):
				s4=0
			Global.hud.get_node("Frontground/Skills/Ultimate/Ultimate").frame=s4
			
			
		changePlayerSkill=true

func ChangeSkillQuality():
		if (selected==0):
			q0+=1
			if (q0>3):
				q0=0
			changeColor("Frontground/Skills/Attack1_Border",q0)
			
		elif (selected==1):
			q1+=1
			if (q1>3):
				q1=0
			changeColor("Frontground/Skills/Attack2_Border",q1)
			
		elif (selected==2):
			q2+=1
			if (q2>3):
				q2=0
			changeColor("Frontground/Skills/Turret",q2)
			
		elif (selected==3):
			q3+=1
			if (q3>3):
				q3=0
			changeColor("Frontground/Skills/Dash",q3)
			
		elif (selected==4):
			q4+=1
			if (q4>3):
				q4=0
			changeColor("Frontground/Skills/Ultimate",q4)
			
		changePlayerSkill=true
	
func changeColor(path,q):
	if (q==0):
		Global.hud.get_node(path).set("color", Color8(150, 201, 49))
	elif (q==1):
		Global.hud.get_node(path).set("color", Color8(76, 76, 204))
	elif (q==2):
		Global.hud.get_node(path).set("color", Color8(117, 0, 196))
	elif (q==3):
		Global.hud.get_node(path).set("color", Color8(255, 149, 1))
