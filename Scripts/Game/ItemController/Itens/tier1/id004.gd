extends Node2D

var id="004"
var item_name="ares shield silver"
var quality=0
var descriptionPositive="+ 2% life steal"
var descriptionNegative="- 1 damage"
var itenGrabFrame=3

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.lifeStealChance+=0.02
	Global.player.baseDamage-=1.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
