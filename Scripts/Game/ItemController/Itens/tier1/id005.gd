extends Node2D

var id="005"
var item_name="ares shield wood"
var quality=0
var descriptionPositive="+ "+ str(AllSkillsValues.hp) +" max hp"
var descriptionNegative="- "+ str(int(AllSkillsValues.percentDamage*100/5)) +"% damage"
var itenGrabFrame=4

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=AllSkillsValues.hp
	Global.player.percentDamage-=AllSkillsValues.percentDamage/5

func _ready():
	Global.ItemController.itenReadyFunction(self)
