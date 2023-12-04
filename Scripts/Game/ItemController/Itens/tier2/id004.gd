extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="004"
var itenGrabFrame=23
var item_name="dionisios cup silver"
var descriptionPositive="+ 4 damage"
var descriptionNegative="- 4% damage"

func addFunction():
	Global.player.baseDamage+=4.0
	Global.player.percentDamage-=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
