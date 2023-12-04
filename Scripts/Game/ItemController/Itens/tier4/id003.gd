extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=3
var id="003"
var itenGrabFrame=47
var item_name="zeus thunder 3"
var descriptionPositive="+ 5 armor and + 5% crit and + 5 damage and + 5% move speed"
var descriptionNegative="- 2 hp regen and - 2% life steal"

func addFunction():
	Global.player.armor+=5
	Global.player.lifeStealChance+=0.05
	Global.player.baseDamage+=5.0
	Global.player.moveSpeedPercentBonus+=0.05
	Global.player.hpRegeneration-=2
	Global.player.lifeStealChance-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
