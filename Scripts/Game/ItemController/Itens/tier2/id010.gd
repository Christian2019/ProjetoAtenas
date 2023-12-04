extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="010"
var itenGrabFrame=29
var item_name="hermes shoes 5"
var descriptionPositive="+ 3 hp regen"
var descriptionNegative=""

func addFunction():
	Global.player.hpRegeneration+=3

func _ready():
	Global.ItemController.itenReadyFunction(self)
