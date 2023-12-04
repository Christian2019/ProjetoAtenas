extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=3
var id="002"
var itenGrabFrame=46
var item_name="zeus thunder 2"
var descriptionPositive="+ 5% life steal and + 20% dodge"
var descriptionNegative="- 6 damage"

func addFunction():
	Global.player.lifeStealChance+=0.05
	Global.player.dodge+=0.2
	Global.player.baseDamage-=6.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
