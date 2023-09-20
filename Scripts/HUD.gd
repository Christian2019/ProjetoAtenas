extends Node2D

var tick =0
var waitTick=2

#Timer
var maxBarSizeX
var timerTick=0
var timerTime=0

#Hp bar
var hpHearthYStartPosition
var maxHpHearthStartSizeY



func _ready():
	maxBarSizeX=$Frontground/TimeLine/ColorRect.size.x
	
	maxHpHearthStartSizeY=$Frontground/HP/ColorRect.size.y
	hpHearthYStartPosition= $Frontground/HP/ColorRect.position.y

func _process(_delta):
	timerControllerBar()
	hpBarController()
	
	if (tick == waitTick):
		updateTimeToNextWave()
		updateResources()

	
	if (tick < waitTick):
		tick+=1

func hpBarController():
	$Frontground/HP/Label.text = str("HP ",Global.player.hp,"/",Global.player.maxHp )
	var hpHearthPostionY = hpHearthYStartPosition+maxHpHearthStartSizeY-(maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp)
	var hpHearthSizeY = maxHpHearthStartSizeY*Global.player.hp/Global.player.maxHp
	$Frontground/HP/ColorRect.size.y=int(hpHearthSizeY)
	$Frontground/HP/ColorRect.position.y= int(hpHearthPostionY)

func updateResources():
	$Frontground/Wood/Label.text =  str("Wood ",Global.player.wood)
	$Frontground/Gold/Label.text =  str("Gold ",Global.player.gold)
	$Frontground/Stone/Label.text =  str("Stone ",Global.player.stone)
	
func updateTimeToNextWave():
	if (Global.Game.get_node("WaveController").battleTime):
		return
	$Frontground/TimeLine/Label2.text = str(Global.Game.get_node("WaveController").timer,"s")
	if (Global.Game.get_node("WaveController").timer!=timerTime):
		timerTime=Global.Game.get_node("WaveController").timer
		timerTick=60*timerTime

func timerControllerBar():
	timerTick-=1
	if (Global.Game.get_node("WaveController").battleTime):
		$Frontground/TimeLine/ColorRect.size.x=0
		$Frontground/TimeLine/Label.text= "Battle Time!"
		$Frontground/TimeLine/Label2.text = ""
		return
	var totalWaitTimeFrames = Global.Game.get_node("WaveController").startTimer*60
	$Frontground/TimeLine/Label.text= "Time to Next Wave"

	if (timerTick>0.25*totalWaitTimeFrames):
		$Frontground/TimeLine/ColorRect.color=Color.GREEN
	else:
		$Frontground/TimeLine/ColorRect.color=Color.RED
	
	var barSizeX = maxBarSizeX*timerTick/totalWaitTimeFrames
	$Frontground/TimeLine/ColorRect.size.x=barSizeX

