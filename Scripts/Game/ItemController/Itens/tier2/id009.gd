extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="009"
var itenGrabFrame=28
var item_name="hermes shoes 4"
var descriptionPositive="+ 2 armor and 6% dodge"
var descriptionNegative="- 3 max hp"

func addFunction():
	Global.player.dodge+=0.06
	Global.player.armor+=2
	Global.player.baseMaxHp-=3.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
