extends Node2D

var id="003"
var item_name="ares shield rock"
var quality=0
var descriptionPositive="+ 5 max hp"
var descriptionNegative="- 1 hp regen"
var itenGrabFrame=2

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=5.0
	Global.player.hpRegeneration-=1

func _ready():
	Global.ItemController.itenReadyFunction(self)
