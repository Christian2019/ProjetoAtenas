extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="003"
var itenGrabFrame=37
var item_name="poseidons staff gold"
var descriptionPositive="+ 8 max hp and 3 hp regen"
var descriptionNegative="- 8% luck"

func addFunction():
	Global.player.baseMaxHp+=8.0
	Global.player.hpRegeneration+=3
	Global.player.luck-=0.08

func _ready():
	Global.ItemController.itenReadyFunction(self)
