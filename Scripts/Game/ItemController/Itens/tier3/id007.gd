extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="007"
var itenGrabFrame=41
var item_name="sword diamond"
var descriptionPositive="+ 30% luck"
var descriptionNegative="- 3 damage"

func addFunction():
	Global.player.luck+=0.3
	Global.player.baseDamage-=3.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
