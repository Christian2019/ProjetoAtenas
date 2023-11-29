extends Node2D

var id="005"
var item_name="ares shield wood"
var quality=0
var descriptionPositive="+ 3 max hp"
var descriptionNegative="- 1% damage"
var itenGrabFrame=4

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=3.0
	Global.player.percentDamage-=0.01

func _ready():
	Global.ItemController.itenReadyFunction(self)
