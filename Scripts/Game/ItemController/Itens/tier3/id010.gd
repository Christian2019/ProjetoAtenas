extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="010"
var itenGrabFrame=44
var item_name="sword wood"
var descriptionPositive="+ 15% move speed and + 10% dodge"
var descriptionNegative="- 5 max hp and - 1 armor"

func addFunction():
	Global.player.armor-=1
	Global.player.baseMaxHp-=5.0
	Global.player.moveSpeedPercentBonus+=0.15
	Global.player.dodge+=0.1

func _ready():
	Global.ItemController.itenReadyFunction(self)
