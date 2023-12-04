extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="006"
var itenGrabFrame=25
var item_name="hermes shoes"
var descriptionPositive="+ 4% crit"
var descriptionNegative=""

func addFunction():
	Global.player.percentCritDamage+=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
