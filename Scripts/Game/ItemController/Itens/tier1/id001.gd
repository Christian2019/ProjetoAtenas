extends Node2D

var id="001"
var item_name="ares shield bronze"
var quality=0
var descriptionPositive="+ 2 damage"
var descriptionNegative="- 1 max hp"
var itenGrabFrame=0

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp-=1.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
