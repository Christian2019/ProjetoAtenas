extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="013"
var itenGrabFrame=12
var item_name="atenas spear gold"
var descriptionPositive="+ 6% crit"
var descriptionNegative="- 3% damage"

func addFunction():
	Global.player.percentCritDamage+=0.06
	Global.player.percentDamage-=0.03

func _ready():
	Global.ItemController.itenReadyFunction(self)
