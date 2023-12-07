extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="019"
var itenGrabFrame=18
var item_name="demeters cifer metal"
var descriptionPositive="+ 10% luck"
var descriptionNegative="- 2% damage"

func addFunction():
	Global.player.luck+=0.1
	Global.player.percentDamage-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
