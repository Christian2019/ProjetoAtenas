extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="006"
var itenGrabFrame=40
var item_name="swoord bronze"
var descriptionPositive="+ 25% damage"
var descriptionNegative="- 3 armor"

func addFunction():
	Global.player.percentDamage+=0.25
	Global.player.armor-=3

func _ready():
	Global.ItemController.itenReadyFunction(self)
