extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="012"
var itenGrabFrame=31
var item_name="hand of stealing gold"
var descriptionPositive="+ 3 max hp and +3% damage and +1 armor and +3% move speed"
var descriptionNegative="-4% crit"

func addFunction():
	Global.player.baseMaxHp+=3.0
	Global.player.percentDamage+=0.03
	Global.player.armor+=1
	Global.player.moveSpeedPercentBonus+=0.03
	Global.player.percentCritDamage-=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
