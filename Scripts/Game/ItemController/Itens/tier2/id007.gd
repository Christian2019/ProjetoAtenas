extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="007"
var itenGrabFrame=26
var item_name="hermes shoes 2"
var descriptionPositive="+ 2 damage"
var descriptionNegative=""

func addFunction():
	Global.player.baseDamage+=2.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
