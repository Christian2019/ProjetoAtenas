extends Node2D

var id="004"
var item_name="ares shield silver"
var quality=0
var descriptionPositive="+ "+ str(AllSkillsValues.lifeStealChance*2*100) +"% life steal"
var descriptionNegative="- "+ str(int(AllSkillsValues.damage)) +" damage"
var itenGrabFrame=3

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.lifeStealChance+=AllSkillsValues.lifeStealChance*2
	Global.player.baseDamage-=AllSkillsValues.damage

func _ready():
	Global.ItemController.itenReadyFunction(self)
