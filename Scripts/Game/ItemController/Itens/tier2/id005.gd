extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="005"
var itenGrabFrame=24
var item_name="dionisios cup wood"
var descriptionPositive="+ 3 damage and +5% move speed"
var descriptionNegative="- 3% crit"

func addFunction():
	Global.player.baseDamage+=3.0
	Global.player.moveSpeedPercentBonus+=0.05
	Global.player.percentCritDamage-=0.03

func _ready():
	Global.ItemController.itenReadyFunction(self)
