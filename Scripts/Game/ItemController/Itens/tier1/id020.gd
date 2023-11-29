extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="020"
var itenGrabFrame=19
var item_name="demeters cifer silver"
var descriptionPositive="+ 4% move speed"
var descriptionNegative="- 6% luck"

func addFunction():
	Global.player.luck-=0.06
	Global.player.moveSpeedPercentBonus+=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
