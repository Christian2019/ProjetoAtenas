extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="001"
var itenGrabFrame=20
var item_name="dionisios cup bronze"
var descriptionPositive="+ 2 damage"
var descriptionNegative="- 2% dodge"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.dodge-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
