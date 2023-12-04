extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=3
var id="005"
var itenGrabFrame=49
var item_name="zeus thunder 5"
var descriptionPositive="+ 3 max hp and + 2 hp regen and + 1% life steal and + 5% damage and + 3% move speed and + 3% dodge and + 1 armor and + 5% luck"
var descriptionNegative=""

func addFunction():
	Global.player.baseMaxHp+=3.0
	Global.player.hpRegeneration+=2
	Global.player.lifeStealChance+=0.01
	Global.player.percentDamage+=0.05
	Global.player.moveSpeedPercentBonus+=0.03
	Global.player.dodge+=0.03
	Global.player.armor+=1
	Global.player.luck+=0.05

func _ready():
	Global.ItemController.itenReadyFunction(self)
