extends Node2D

var attack1_zeus
var attack1_poseidon
var attack1_hades

var attack2_zeus
var attack2_poseidon
var attack2_hades

var dash_zeus
var dash_poseidon

func _ready():
	Global.MathController=self
	attack1_zeus= get_node("Attack1/Zeus")
	attack1_poseidon=get_node("Attack1/Poseidon")
	attack1_hades=get_node("Attack1/Hades")
	
	attack2_zeus= get_node("Attack2/Zeus")
	attack2_poseidon=get_node("Attack2/Poseidon")
	attack2_hades=get_node("Attack2/Hades")
	
	dash_zeus=get_node("Dash/Zeus")
	dash_poseidon=get_node("Dash/Poseidon")

func clearArrays():
	attack1_zeus.electrified.clear()
	attack1_poseidon.waterDamage.clear()
	attack1_poseidon.heavyDamageHits=0
	attack2_hades.array.clear()
	attack2_hades.positions.clear()

func damageController(damage,target):
	var finalDamage=damage
	var crit=false
	var miss=false
	if (target.name=="Player"):
		enemyAttacksEffects()
				
		#Armor
		var armor=Global.player.armor
		var armorTankMultiplier
		if (armor>=0):
			armorTankMultiplier = 1+ (armor*0.05)
		else:
			armor *=-1
			armorTankMultiplier = 1/ (1+(armor*0.05))
		
		finalDamage/=armorTankMultiplier
		
		#Dodge
		if (Global.player.dodge>0):
			var dodge
			if(Global.player.dodge>Global.player.maxDodge):
				dodge=Global.player.maxDodge
			else:
				dodge=Global.player.dodge
			
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=dodge):
				miss=true
				finalDamage=0

		spawnDamage(finalDamage,target,crit,true,miss,false)
		
	elif (target.name!="Center"):
		
		#Effects
		finalDamage=effects(target,finalDamage)

		#Stats Damage Extra
		finalDamage*=Global.player.baseDamage*Global.player.percentDamage

		#Crit
		if (Global.player.percentCritDamage>0):
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=int(Global.player.percentCritDamage*100)):
				finalDamage*=2
				crit=true
		
		#LifeStealChance
		if (Global.player.lifeStealChance>0):
			var r = RandomNumberGenerator.new().randi_range(0, 100)
			if (r<=int(Global.player.lifeStealChance*100)):
				Global.player.hp+=1
				if Global.player.hp>Global.player.maxHp:
					Global.player.hp=Global.player.maxHp
				spawnDamage(finalDamage,Global.player,crit,false,miss,true)

		spawnDamage(finalDamage,target,crit,false,miss,false)

	target.hp-=finalDamage

func enemyAttacksEffects():
	dash_poseidon.effect()
	
	
func effects(target,finalDamage):
	
	finalDamage=attack1_poseidon.effect(target,finalDamage)
	finalDamage=attack1_zeus.effect(target,finalDamage)
		
	return finalDamage

func spawnDamage(finalDamage,target,crit,colorBlue,miss,lifeSteal):
	var labeldamage=PreLoads.labelDamage.instantiate()
	labeldamage.damage=finalDamage
	labeldamage.crit=crit
	labeldamage.colorBlue=colorBlue
	labeldamage.miss=miss
	labeldamage.lifeSteal=lifeSteal
	add_child(labeldamage)
	labeldamage.global_position=target.global_position
	

func removeObj(obj,array):
	array.erase(obj)
			
func checkIfExist(name,array):
	for i in range(0,array.size(),1):
		if itsValid(array[i]):
			if (array[i].element.name==name):
				return true
	return false
	
func itsValid(element):
	if (element.objectReference.get_ref()):
		return true
	return false

func getElementIndex(element,array):
	for i in range(0,array.size(),1):
		if itsValid(array[i]):
			if (array[i].element.name==element.name):
				return i
