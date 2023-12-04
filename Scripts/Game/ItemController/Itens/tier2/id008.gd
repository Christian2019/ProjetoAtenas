extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="008"
var itenGrabFrame=27
var item_name="hermes shoes 3"
var descriptionPositive="+ 8% dodge"
var descriptionNegative="- 1 armor"

func addFunction():
	Global.player.dodge+=0.08
	Global.player.armor-=1

func _ready():
	Global.ItemController.itenReadyFunction(self)
