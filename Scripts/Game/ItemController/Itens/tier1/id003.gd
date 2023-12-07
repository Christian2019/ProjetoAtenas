extends Node2D

var id="003"
var item_name="ares shield rock"
var quality=0
var descriptionPositive="+ "+ str(int(AllSkillsValues.hp*2)) +" max hp"
var descriptionNegative="- "+ str(int(AllSkillsValues.hpRegeneration/2)) +" hp regen"
var itenGrabFrame=2

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=AllSkillsValues.hp*2
	Global.player.hpRegeneration-=AllSkillsValues.hpRegeneration/2

func _ready():
	Global.ItemController.itenReadyFunction(self)
