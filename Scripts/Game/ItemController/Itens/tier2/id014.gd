extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="014"
var itenGrabFrame=33
var item_name="hand of stealing human"
var descriptionPositive="+ 2 armor"
var descriptionNegative="- 3% damage"

func addFunction():
	Global.player.armor+=2
	Global.player.percentDamage-=0.03

func _ready():
	Global.ItemController.itenReadyFunction(self)
