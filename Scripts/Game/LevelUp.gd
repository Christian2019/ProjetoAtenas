extends Node2D

var level=0
var levelExperience=0
var nextLevelExp=5.0
var upgrades=0
var selected=4
var rerollPrice=1
var freeChooseButton=false

#Base values Upgrade
var hp=AllSkillsValues.hp
var hpRegeneration=AllSkillsValues.hpRegeneration
var lifeStealChance=AllSkillsValues.lifeStealChance
var percentDamage=AllSkillsValues.percentDamage
var damage=AllSkillsValues.damage
var attack_Speed = AllSkillsValues.attack_Speed
var percentCritDamage=AllSkillsValues.percentCritDamage
var armor=AllSkillsValues.armor
var dodge=AllSkillsValues.dodge
var moveSpeed=AllSkillsValues.moveSpeed
var luck=AllSkillsValues.luck

#Base Quality Chance Table
var tier2={"minLevel":1,"plusChancePerLevel":0.06,"maxChance":0.6}
var tier3={"minLevel":3,"plusChancePerLevel":0.02,"maxChance":0.25}
var tier4={"minLevel":7,"plusChancePerLevel":0.0023,"maxChance":0.08}

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
	
	var totalPossibilites=10000


	var t4=testChances(tier4,totalPossibilites,rng)
	#print("t4: ",t4.chance)
	if (t4.bol):
		slot.quality=3
		return
	totalPossibilites-=t4.chance
	
	var t3=testChances(tier3,totalPossibilites,rng)
	#print("t3: ",t3.chance)
	if (t3.bol):
		slot.quality=2
		return
	totalPossibilites-=t3.chance
	
	var t2=testChances(tier2,totalPossibilites,rng)
	#print("t2: ",t2.chance)
	if (t2.bol):
		slot.quality=1
		return
	totalPossibilites-=t2.chance
	
	slot.quality=0

func testChances(tier,totalPossibilites,rng):
	var chance
	if (tier.minLevel<=level):
		chance=(level*tier.plusChancePerLevel)*(1+Global.player.luck)
		if (chance>tier.maxChance):
			chance=tier.maxChance
		chance= int(chance*totalPossibilites)
		var r=rng.randi_range(0, totalPossibilites)
		#print("Random: ",r)
		if (r<chance):
			return {"bol":true,"chance":chance}
		else:
			return {"bol":false,"chance":chance}
	else:
		return {"bol":false,"chance":0}
		
func _process(delta):
	levelUp()
	if (Global.WaveController.mining and upgrades>0 and !visible):
		get_tree().paused = true
		visible=true
		update()
	if (visible):
		lvlupController()
		
		
func update():
	updateUpgrade(0,slot1)
	updateUpgrade(1,slot2)
	updateUpgrade(2,slot3)
	updateUpgrade(3,slot4)
	$Chooses/Reroll/Label.text="Reroll "+str(rerollPrice)
	$Label2.text="upgrades: "+str(upgrades)
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
		chanUpL3(upgrade,slot,armor,"Armor",1)
	elif (slot.type==1):
		chanUpL3(upgrade,slot,attack_Speed,"Attack Speed %",100)
	elif (slot.type==2):
		chanUpL3(upgrade,slot,damage,"Damage",1)
	elif (slot.type==3):
		chanUpL3(upgrade,slot,dodge,"Dodge %",100)
	elif (slot.type==4):
		chanUpL3(upgrade,slot,hp,"Max Hp",1)
	elif (slot.type==5):
		chanUpL3(upgrade,slot,hpRegeneration,"Hp Regen",1)
	elif (slot.type==6):
		chanUpL3(upgrade,slot,lifeStealChance,"Life Steal %",100)
	elif (slot.type==7):
		chanUpL3(upgrade,slot,luck,"Luck  %",100)
	elif (slot.type==8):
		chanUpL3(upgrade,slot,moveSpeed,"Move Speed %",100)
	elif (slot.type==9):
		chanUpL3(upgrade,slot,percentCritDamage,"Crit  %",100)
	elif (slot.type==10):
		chanUpL3(upgrade,slot,percentDamage,"Damage %",100)

func chanUpL3(upgrade,slot,status,text,multiplierLabel):
	slot.value=status*(slot.quality+1)
	upgrade.get_node("Label3").text="+ "+str(int(slot.value*multiplierLabel))+" "+text
	
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
		if !freeChooseButton:
			freeChooseButton=true
			return
		if (selected==4 and Global.player.dracma>rerollPrice):
			Global.player.dracma-=rerollPrice
			rerollPrice+=1
			getRandomOptions()
		else:
			applyStatus()
			getRandomOptions()
			decresseUpgrades()
			update()

func decresseUpgrades():
	upgrades-=1
	if (upgrades==0):
		get_tree().paused = false
		visible=false
		

func applyStatus():	
	var slot
	
	if (selected==0):
		slot=slot1
	elif (selected==1):
		slot=slot2
	elif (selected==2):
		slot=slot3			
	elif (selected==3):
		slot=slot4
	
	if (slot.type==0):
		Global.player.armor+=slot.value
	elif (slot.type==1):
		Global.player.attack_Speed+=slot.value
	elif (slot.type==2):
		Global.player.baseDamage+=slot.value
	elif (slot.type==3):
		Global.player.dodge+=slot.value
	elif (slot.type==4):
		Global.player.baseMaxHp+=slot.value
		Global.player.multiplierController()
	elif (slot.type==5):
		Global.player.hpRegeneration+=slot.value
	elif (slot.type==6):
		Global.player.lifeStealChance+=slot.value
	elif (slot.type==7):
		Global.player.luck+=slot.value
	elif (slot.type==8):
		Global.player.moveSpeedPercentBonus+=slot.value
		Global.player.multiplierController()
	elif (slot.type==9):
		Global.player.percentCritDamage+=slot.value
	elif (slot.type==10):
		Global.player.percentDamage+=slot.value
			
func levelUp():
	if (levelExperience>=nextLevelExp):
		level+=1
		levelExperience=0
		nextLevelExp*=1.2
		upgrades+=1
		freeChooseButton=false
