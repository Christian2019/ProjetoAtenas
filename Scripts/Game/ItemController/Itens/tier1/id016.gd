extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="016"
var itenGrabFrame=15
var item_name="demeters cifer bronze"
var descriptionPositive="+ 2 damage"
var descriptionNegative="- 3% move speed"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.moveSpeedPercentBonus-=0.03

func _ready():
	Global.ItemController.itenReadyFunction(self)
