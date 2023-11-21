extends Node2D

var level=0
var levelExperience=50
var nextLevelExp=100
var upgrades=1
var selected=4
var rerollPrice=1

#Base values Upgrade
var hp=3.0
var hpRegeneration=2.0
var lifeStealChance=0.01
var percentDamage=0.05
var damage=2.0
var attack_Speed = 0.05
var percentCritDamage=0.03
var armor=1.0
var dodge=0.03
var moveSpeed=0.03
var luck=0.05

var slot1={"type":0,"value":0,"quality":0}
var slot2={"type":0,"value":0,"quality":0}
var slot3={"type":0,"value":0,"quality":0}
var slot4={"type":0,"value":0,"quality":0}

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.LevelUp=self
	getRandomOptions()
	
	
func getRandomOptions():
	var rng = RandomNumberGenerator.new()
	var t1 = rng.randi_range(0, 10)
	
	var t2 = rng.randi_range(0, 10)
	while (t2==t1):
		t2 = rng.randi_range(0, 10)
		
	var t3 = rng.randi_range(0, 10)
	while (t3==t1 or t3==t2):
		t3 = rng.randi_range(0, 10)
	
	var t4 = rng.randi_range(0, 10)
	while (t4==t1 or t4==t2 or t4==t3):
		t4 = rng.randi_range(0, 10)
	
	rand(slot1, rng,t1)
	rand(slot2, rng,t2)
	rand(slot3, rng,t3)
	rand(slot4, rng,t4)
	update()
	
func rand(slot, rng,t):
	slot.type=t
	slot.quality=rng.randi_range(0, 3)
	
func _process(delta):
	levelUp()
	if (Global.WaveController.mining and upgrades>0 and !visible):
		Global.Stats.visible=true
		get_tree().paused = true
		visible=true
	if (visible):
		lvlupController()
		
		
func update():
	updateUpgrade(0,slot1)
	updateUpgrade(1,slot2)
	updateUpgrade(2,slot3)
	updateUpgrade(3,slot4)
	$Chooses/Reroll/Label.text="Reroll "+str(rerollPrice)
	updateSelected()
	
func updateSelected():
	for i in range(0,5,1):
		if (i==selected):
			$Chooses.get_child(selected).get_node("Selected2").visible=false
		else:
			$Chooses.get_child(i).get_node("Selected2").visible=true
			
func updateUpgrade(child,slot):
	var upgrade =$Upgrades.get_child(child)
	upgrade.get_node("Level1").visible=false
	upgrade.get_node("Level2").visible=false
	upgrade.get_node("Level3").visible=false
	upgrade.get_node("Level4").visible=false
	if (slot.quality==0):
		upgrade.get_node("Level1").visible=true
		upgrade.get_node("Label").text="Level 1"
	elif (slot.quality==1):
		upgrade.get_node("Level2").visible=true
		upgrade.get_node("Label").text="Level 2"
	elif (slot.quality==2):
		upgrade.get_node("Level3").visible=true
		upgrade.get_node("Label").text="Level 3"
	elif (slot.quality==3):
		upgrade.get_node("Level4").visible=true
		upgrade.get_node("Label").text="Level 4"
		
	upgrade.get_node("AnimatedSprite2D").frame=slot.type
	
	if (slot.type==0):
		chanUpL3(upgrade,slot,armor,"Armor")
	elif (slot.type==1):
		chanUpL3(upgrade,slot,attack_Speed*100,"Attack Speed")
	elif (slot.type==2):
		chanUpL3(upgrade,slot,damage,"Damage")
	elif (slot.type==3):
		chanUpL3(upgrade,slot,dodge*100,"Dodge")
	elif (slot.type==4):
		chanUpL3(upgrade,slot,hp,"Max Hp")
	elif (slot.type==5):
		chanUpL3(upgrade,slot,hpRegeneration,"Hp Regen")
	elif (slot.type==6):
		chanUpL3(upgrade,slot,lifeStealChance*100,"Life Steal %")
	elif (slot.type==7):
		chanUpL3(upgrade,slot,luck*100,"Luck")
	elif (slot.type==8):
		chanUpL3(upgrade,slot,moveSpeed*100,"Move Speed %")
	elif (slot.type==9):
		chanUpL3(upgrade,slot,percentCritDamage*100,"Crit")
	elif (slot.type==10):
		chanUpL3(upgrade,slot,percentDamage*100,"Damage %")

func chanUpL3(upgrade,slot,status,text):
	slot.value=status*(slot.quality+1)
	upgrade.get_node("Label3").text="+ "+str(int(slot.value))+" "+text
	
func lvlupController():
	if (Input.is_action_just_pressed("Move_Right")):
		selected+=1
		if (selected>4):
			selected=0
		update()
	
	elif (Input.is_action_just_pressed("Move_Left")):
		selected-=1
		if (selected<0):
			selected=4
		update()
		
	elif (Input.is_action_just_pressed("Move_Up")):
		selected=0
		update()
		
	elif (Input.is_action_just_pressed("Move_Down")):
		selected=4
		update()
	
	elif (Input.is_action_just_pressed("Select")):
		if (selected==4 and Global.player.dracma>rerollPrice):
			Global.player.dracma-=rerollPrice
			rerollPrice+=1
			getRandomOptions()
				
	
func levelUp():
	if (levelExperience>nextLevelExp):
		level+=1
		levelExperience=0
		nextLevelExp*=2
		upgrades+=1
