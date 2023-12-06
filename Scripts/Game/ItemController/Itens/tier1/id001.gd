extends Node2D

var id="001"
var item_name="ares shield bronze"
var quality=0
var descriptionPositive="+"+str(int(AllSkillsValues.damage*2))+" damage"
var descriptionNegative="-"+str(int(AllSkillsValues.hp/3)) +" max hp"
var itenGrabFrame=0

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	
	Global.player.baseDamage+=AllSkillsValues.damage*2
	Global.player.baseMaxHp-=AllSkillsValues.hp/3

func _ready():
	Global.ItemController.itenReadyFunction(self)
