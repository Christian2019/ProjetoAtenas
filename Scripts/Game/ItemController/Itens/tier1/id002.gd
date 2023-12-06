extends Node2D

var id="002"
var item_name="ares shield gold"
var quality=0
var descriptionPositive="+"+ str(int(AllSkillsValues.damage)) +" damage"
var descriptionNegative=""
var itenGrabFrame=1

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseDamage+=AllSkillsValues.damage

func _ready():
	Global.ItemController.itenReadyFunction(self)
