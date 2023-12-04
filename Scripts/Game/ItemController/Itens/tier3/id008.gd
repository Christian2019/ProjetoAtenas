extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=2
var id="008"
var itenGrabFrame=42
var item_name="sword gold"
var descriptionPositive="+ 6 damage"
var descriptionNegative="- 8% attack speed"

func addFunction():
	Global.player.attack_Speed-=0.08
	Global.player.baseDamage+=6.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
