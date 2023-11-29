extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="009"
var item_name="artemis bow 4"
var itenGrabFrame=8
var descriptionPositive="+ 1 armor and +1 damage"
var descriptionNegative="- 2 max hp"

func addFunction():
	Global.player.baseDamage+=1.0
	Global.player.armor+=1
	Global.player.baseMaxHp-=2.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
