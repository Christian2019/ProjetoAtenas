extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="005"
var itenGrabFrame=39
var item_name="poseidons staff silver"
var descriptionPositive="+ 10% move speed and + 3% life steal"
var descriptionNegative="- 8% luck"

func addFunction():
	Global.player.lifeStealChance+=0.03
	Global.player.moveSpeedPercentBonus+=0.1
	Global.player.luck-=0.08

func _ready():
	Global.ItemController.itenReadyFunction(self)
