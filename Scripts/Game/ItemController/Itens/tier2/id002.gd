extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="002"
var itenGrabFrame=21
var item_name="dionisios cup diamond"
var descriptionPositive="+ 8 max hp"
var descriptionNegative="- 4% dodge"

func addFunction():
	Global.player.baseMaxHp+=8.0
	Global.player.dodge-=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
