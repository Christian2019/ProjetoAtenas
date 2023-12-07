extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=1
var id="013"
var itenGrabFrame=32
var item_name="hand of stealing green"
var descriptionPositive="+ 6% luck and +2 damage"
var descriptionNegative="- 5% damage"

func addFunction():
	Global.player.luck+=0.06
	Global.player.baseDamage+=2.0
	Global.player.percentDamage-=0.05

func _ready():
	Global.ItemController.itenReadyFunction(self)
