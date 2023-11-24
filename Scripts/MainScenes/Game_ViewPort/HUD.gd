extends Node2D

var tick =0
var waitTick=2

#Timer
var maxTimerStartSizeY
var timerYStartPosition
var timerTick=0
var timerTime=0

#Hp bar player
var hpHearthYStartPosition
var maxHpHearthStartSizeY

#Hp bar centerPoint
var centerPointhpHearthYStartPosition
var centerPointmaxHpHearthStartSizeY

#Ultimate cd
var ultimate_frame=0
var max_ultimate_frame=0
var ultimatecdBoxYStartPosition
var ultimatecdBoxStartSizeY

var waveController
var actualWave

#LevelUp
var maxBarSizeX_levelUp

func _ready():
	Global.hud=self
	
	#Timer
	maxTimerStartSizeY=$TimeLine/ColorRect.size.y
	timerYStartPosition= $TimeLine/ColorRect.position.y
	
	maxHpHearthStartSizeY=$HP/ColorRect.size.y
	hpHearthYStartPosition= $HP/ColorRect.position.y
	
	
	centerPointmaxHpHearthStartSizeY= $CenterPointHp/ColorRect.size.y
	centerPointhpHearthYStartPosition=$CenterPointHp/ColorRect.position.y
		
	ultimatecdBoxYStartPosition= $Skills/Ultimate/cd/ColorRect.position.y
	ultimatecdBoxStartSizeY=$Skills/Ultimate/cd/ColorRect.size.y
	
	maxBarSizeX_levelUp=$LevelUp/ColorRect.size.x

func _process(_delta):
	getWave()
	hpBarController()
	centerPointhpBarController()
	ultimate()
	timerControllerBar()
	updateResources()
	dracma()
	dracmaBag()
	wave()
	levelUp()
	
func levelUp():
	$LevelUp/Label.text="Level: "+str(Global.LevelUp.level)
	$LevelUp/Label2.text=str(Global.LevelUp.levelExperience)+"/"+str(int(Global.LevelUp.nextLevelExp))
	$LevelUp/ColorRect.size.x=int(maxBarSizeX_levelUp*(float(Global.LevelUp.levelExperience)/float(Global.LevelUp.nextLevelExp)))
	

func dracma():
	$Dracma/Label2.text= str(Global.player.dracma)

func dracmaBag():
	$DracmaBag/Label2.text= str(Global.player.dracmaBag)
	
func wave():
	$Wave/Label.text=str("Wave ",waveController.wave)
	if ($Wave/AnimatedSprite2D.frame!=(waveController.wave-1)):
		$Wave/AnimatedSprite2D.frame=(waveController.wave-1)

func getWave():
	waveController=Global.Game.get_node("WaveController")
	actualWave=waveController.get_child(waveController.wave-1)

func ultimate():
	if (Global.player.permissions[4]):
		if ($Skills/Ultimate/cd/ColorRect.visible or $Skills/Ultimate/cd/ColorRect2.visible):
			$Skills/Ultimate/cd/ColorRect.visible=false
			$Skills/Ultimate/cd/ColorRect2.visible=false
			if (ultimate_frame!=0):
				ultimate_frame=0
				max_ultimate_frame=0
				var ultimatecdBoxPostionY = ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY-(ultimatecdBoxStartSizeY*(max_ultimate_frame-ultimate_frame)/max_ultimate_frame)
				var ultimatecdBoxSizeY = (ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY)-ultimatecdBoxPostionY
				$Skills/Ultimate/cd/ColorRect.size.y=int(ultimatecdBoxSizeY)
				$Skills/Ultimate/cd/ColorRect.position.y= int(ultimatecdBoxPostionY)
		return
	
	if(max_ultimate_frame==0):
		if (!$Skills/Ultimate/cd/ColorRect2.visible):
			$Skills/Ultimate/cd/ColorRect2.visible=true
		
		return
	
	if (!$Skills/Ultimate/cd/ColorRect.visible):
		$Skills/Ultimate/cd/ColorRect2.visible=false
		$Skills/Ultimate/cd/ColorRect.visible=true
	ultimate_frame+=1
			
	
	var ultimatecdBoxPostionY = ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY-(ultimatecdBoxStartSizeY*(max_ultimate_frame-ultimate_frame)/max_ultimate_frame)
	var ultimatecdBoxSizeY = (ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY)-ultimatecdBoxPostionY
	$Skills/Ultimate/cd/ColorRect.size.y=int(ultimatecdBoxSizeY)
	$Skills/Ultimate/cd/ColorRect.position.y= int(ultimatecdBoxPostionY)



func hpBarController():
	$HP/CurrentHp.text=str(int(Global.player.hp))
	$HP/MaxHp.text=str(int(Global.player.maxHp))
	var hpHearthPostionY = hpHearthYStartPosition+maxHpHearthStartSizeY-(maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp)
	var hpHearthSizeY = maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp
	$HP/ColorRect.size.y=int(hpHearthSizeY)
	$HP/ColorRect.position.y= int(hpHearthPostionY)

	
func centerPointhpBarController():
	$CenterPointHp/CurrentHp.text=str(int(Global.Game.get_node("Zones/Center").hp))
	$CenterPointHp/MaxHp.text=str(int(Global.Game.get_node("Zones/Center").maxHp))
	var centerPointhpHearthPostionY = centerPointhpHearthYStartPosition+centerPointmaxHpHearthStartSizeY-(centerPointmaxHpHearthStartSizeY*Global.Game.get_node("Zones/Center").hp/Global.Game.get_node("Zones/Center").maxHp)
	var centerPointhpHearthSizeY = centerPointmaxHpHearthStartSizeY*Global.Game.get_node("Zones/Center").hp/Global.Game.get_node("Zones/Center").maxHp
	$CenterPointHp/ColorRect.size.y=int(centerPointhpHearthSizeY)
	$CenterPointHp/ColorRect.position.y= int(centerPointhpHearthPostionY)

	


func updateResources():
	$Wood/Label.text =  str(Global.player.wood)
	$Gold/Label.text =  str(Global.player.gold)
	$Stone/Label.text =  str(Global.player.stone)
	

func timerControllerBar():
	$TimeLine/Label2.text = str(waveController.timer,"s")
	var frame
	var maxFrame
	
	if (waveController.mining):
		$TimeLine/Label.text= "Time to Next Wave"
		frame=actualWave.miningFrame
		maxFrame=actualWave.get_parent().mining_max_duration_frames
	else:
		$TimeLine/Label.text= "Battle Time!"
		frame=actualWave.battleFrame
		maxFrame=actualWave.battle_max_duration_frames

	if (frame<0.75*maxFrame):
		$TimeLine/ColorRect.color=Color8(213, 195, 59)
	else:
		$TimeLine/ColorRect.color=Color.RED

	var tpy = timerYStartPosition+maxTimerStartSizeY-(maxTimerStartSizeY*(maxFrame-frame)/maxFrame)
	var tsy = maxTimerStartSizeY*(maxFrame-frame)/maxFrame
	$TimeLine/ColorRect.size.y=int(tsy)
	$TimeLine/ColorRect.position.y= int(tpy)

