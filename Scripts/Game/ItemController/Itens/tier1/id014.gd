extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="014"
var itenGrabFrame=13
var item_name="atenas spear silver"
var descriptionPositive="+ 10% luck"
var descriptionNegative="- 1 damage"

func addFunction():
	Global.player.luck+=0.1
	Global.player.baseDamage-=1.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
