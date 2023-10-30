extends Node2D

var tick =0
var waitTick=2

#Timer
var maxBarSizeX
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


func _ready():
	Global.hud=self
	
	maxBarSizeX=$Frontground/TimeLine/ColorRect.size.x
	
	maxHpHearthStartSizeY=$Frontground/HP/ColorRect.size.y
	hpHearthYStartPosition= $Frontground/HP/ColorRect.position.y
	
	
	centerPointmaxHpHearthStartSizeY= $Frontground/CenterPointHp/ColorRect.size.y
	centerPointhpHearthYStartPosition=$Frontground/CenterPointHp/ColorRect.position.y
		
	ultimatecdBoxYStartPosition= $Frontground/Ultimate/ColorRect.position.y
	ultimatecdBoxStartSizeY=$Frontground/Ultimate/ColorRect.size.y

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

func dracma():
	$Frontground/Dracma/Label2.text= str(Global.player.dracma)

func dracmaBag():
	$Frontground/DracmaBag/Label2.text= str(Global.player.dracmaBag)
	
func wave():
	$Frontground/Wave/Label2.text=str(waveController.wave)
	if ($Frontground/Wave/AnimatedSprite2D.frame!=(waveController.wave-1)):
		$Frontground/Wave/AnimatedSprite2D.frame=(waveController.wave-1)

func getWave():
	waveController=Global.Game.get_node("WaveController")
	actualWave=waveController.get_child(waveController.wave-1)

func ultimate():
	get_node("Frontground/Ultimate/Label2").text=str(Global.player.ultimateWaveActivations,"/",Global.player.ultimateMaxActivations)
	if (Global.player.permissions[4]):
		if ($Frontground/Ultimate/ColorRect.visible or $Frontground/Ultimate/ColorRect2.visible):
			$Frontground/Ultimate/ColorRect.visible=false
			$Frontground/Ultimate/ColorRect2.visible=false
			if (ultimate_frame!=0):
				ultimate_frame=0
				max_ultimate_frame=0
				var ultimatecdBoxPostionY = ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY-(ultimatecdBoxStartSizeY*(max_ultimate_frame-ultimate_frame)/max_ultimate_frame)
				var ultimatecdBoxSizeY = (ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY)-ultimatecdBoxPostionY
				$Frontground/Ultimate/ColorRect.size.y=int(ultimatecdBoxSizeY)
				$Frontground/Ultimate/ColorRect.position.y= int(ultimatecdBoxPostionY)
		return
	
	if(max_ultimate_frame==0):
		if (!$Frontground/Ultimate/ColorRect2.visible):
			$Frontground/Ultimate/ColorRect2.visible=true
		
		return
	
	if (!$Frontground/Ultimate/ColorRect.visible):
		$Frontground/Ultimate/ColorRect2.visible=false
		$Frontground/Ultimate/ColorRect.visible=true
	ultimate_frame+=1
			
	
	var ultimatecdBoxPostionY = ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY-(ultimatecdBoxStartSizeY*(max_ultimate_frame-ultimate_frame)/max_ultimate_frame)
	var ultimatecdBoxSizeY = (ultimatecdBoxYStartPosition+ultimatecdBoxStartSizeY)-ultimatecdBoxPostionY
	$Frontground/Ultimate/ColorRect.size.y=int(ultimatecdBoxSizeY)
	$Frontground/Ultimate/ColorRect.position.y= int(ultimatecdBoxPostionY)



func hpBarController():
	$Frontground/HP/Label.text = str("HP ",Global.player.hp,"/",Global.player.maxHp )
	var hpHearthPostionY = hpHearthYStartPosition+maxHpHearthStartSizeY-(maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp)
	var hpHearthSizeY = maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp
	$Frontground/HP/ColorRect.size.y=int(hpHearthSizeY)
	$Frontground/HP/ColorRect.position.y= int(hpHearthPostionY)

	
func centerPointhpBarController():
	$Frontground/CenterPointHp/Label.text = str("CHP ",Global.Game.get_node("Zones/Center").hp,"/",Global.Game.get_node("Zones/Center").maxHp )
	var centerPointhpHearthPostionY = centerPointhpHearthYStartPosition+centerPointmaxHpHearthStartSizeY-(centerPointmaxHpHearthStartSizeY*Global.Game.get_node("Zones/Center").hp/Global.Game.get_node("Zones/Center").maxHp)
	var centerPointhpHearthSizeY = centerPointmaxHpHearthStartSizeY*Global.Game.get_node("Zones/Center").hp/Global.Game.get_node("Zones/Center").maxHp
	$Frontground/CenterPointHp/ColorRect.size.y=int(centerPointhpHearthSizeY)
	$Frontground/CenterPointHp/ColorRect.position.y= int(centerPointhpHearthPostionY)

	


func updateResources():
	$Frontground/Wood/Label.text =  str("Wood ",Global.player.wood)
	$Frontground/Gold/Label.text =  str("Gold ",Global.player.gold)
	$Frontground/Stone/Label.text =  str("Stone ",Global.player.stone)
	

func timerControllerBar():
	$Frontground/TimeLine/Label2.text = str(waveController.timer,"s")
	var frame
	var maxFrame
	
	if (waveController.mining):
		$Frontground/TimeLine/Label.text= "Time to Next
 Wave"
		frame=actualWave.miningFrame
		maxFrame=actualWave.get_parent().mining_max_duration_frames
	else:
		$Frontground/TimeLine/Label.text= "Battle Time!"
		frame=actualWave.battleFrame
		maxFrame=actualWave.battle_max_duration_frames

	if (frame<0.75*maxFrame):
		$Frontground/TimeLine/ColorRect.color=Color.GREEN
	else:
		$Frontground/TimeLine/ColorRect.color=Color.RED
	
	$Frontground/TimeLine/ColorRect.size.x=int(maxBarSizeX*(maxFrame-frame)/maxFrame)

