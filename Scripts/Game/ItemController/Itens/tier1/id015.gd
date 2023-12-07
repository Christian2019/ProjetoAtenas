extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="015"
var itenGrabFrame=14
var item_name="atenas spear wood"
var descriptionPositive="+ 3 hp regen"
var descriptionNegative="- 2% luck"

func addFunction():
	Global.player.hpRegeneration+=3
	Global.player.luck-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
