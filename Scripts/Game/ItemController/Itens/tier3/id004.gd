extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="004"
var itenGrabFrame=38
var item_name="poseidons staff purple"
var descriptionPositive="+ 20% luck and + 6% dodge"
var descriptionNegative="- 2% life steal"

func addFunction():
	Global.player.lifeStealChance-=0.02
	Global.player.dodge+=0.06
	Global.player.luck+=0.2

func _ready():
	Global.ItemController.itenReadyFunction(self)
