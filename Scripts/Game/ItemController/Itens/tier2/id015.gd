extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="015"
var itenGrabFrame=34
var item_name="hand of stealing silver"
var descriptionPositive="+ 10% damage"
var descriptionNegative="- 4% attack speed"

func addFunction():
	Global.player.percentDamage+=0.1
	Global.player.attack_Speed-=0.04

func _ready():
	Global.ItemController.itenReadyFunction(self)
