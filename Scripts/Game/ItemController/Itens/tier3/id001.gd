extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="001"
var itenGrabFrame=35
var item_name="poseidons staff bronze"
var descriptionPositive="+ 2 damage and 10% attack speed"
var descriptionNegative="- 6% damage"

func addFunction():
	Global.player.percentDamage-=0.06
	Global.player.attack_Speed+=0.1
	Global.player.baseDamage+=2.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
