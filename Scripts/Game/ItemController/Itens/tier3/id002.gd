extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="002"
var itenGrabFrame=36
var item_name="poseidons staff diamond"
var descriptionPositive="+ 10% crit"
var descriptionNegative="- 1 armor"

func addFunction():
	Global.player.armor-=1
	Global.player.percentCritDamage+=0.1

func _ready():
	Global.ItemController.itenReadyFunction(self)
