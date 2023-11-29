extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="003"
var itenGrabFrame=22
var item_name="dionisios cup gold"
var descriptionPositive="+ 2 damage and 2 hp regen"
var descriptionNegative="- 2% move speed"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.hpRegeneration+=2
	Global.player.moveSpeedPercentBonus-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
