extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=3
var id="001"
var itenGrabFrame=45
var item_name="zeus thunder"
var descriptionPositive="+ 18 damage"
var descriptionNegative="- 5% move speed and - 1 armor"

func addFunction():
	Global.player.armor-=1
	Global.player.moveSpeedPercentBonus-=0.05
	Global.player.baseDamage+=18.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
