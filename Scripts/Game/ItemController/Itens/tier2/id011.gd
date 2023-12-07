extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="011"
var itenGrabFrame=30
var item_name="hand of stealing bronze"
var descriptionPositive="+ 3 damage"
var descriptionNegative=""

func addFunction():
	Global.player.baseDamage+=3.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
