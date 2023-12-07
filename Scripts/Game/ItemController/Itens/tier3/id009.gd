extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="009"
var itenGrabFrame=43
var item_name="sword silver"
var descriptionPositive="+ 3 armor and + 5 max hp"
var descriptionNegative="- 5% move speed"

func addFunction():
	Global.player.armor+=3
	Global.player.baseMaxHp+=5.0
	Global.player.moveSpeedPercentBonus-=0.05

func _ready():
	Global.ItemController.itenReadyFunction(self)
