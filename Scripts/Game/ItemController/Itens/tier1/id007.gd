extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="007"
var item_name="artemis bow 2"
var itenGrabFrame=6
var descriptionPositive="+ 10% attack speed"
var descriptionNegative="- 2% damage"

func addFunction():
	Global.player.attack_Speed+=0.1
	Global.player.percentDamage-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
