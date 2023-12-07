extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="010"
var item_name="artemis bow 5"
var itenGrabFrame=9
var descriptionPositive="+ 3 damage"
var descriptionNegative="- 2% crit"

func addFunction():
	Global.player.baseDamage+=3.0
	Global.player.percentCritDamage-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
