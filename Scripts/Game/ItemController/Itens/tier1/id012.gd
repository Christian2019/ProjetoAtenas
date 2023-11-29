extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="012"
var itenGrabFrame=11
var item_name="atenas spear diamond"
var descriptionPositive="+ 7% damage"
var descriptionNegative="- 2 max hp"

func addFunction():
	Global.player.percentDamage+=0.07
	Global.player.baseMaxHp-=2.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
