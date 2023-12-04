extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="011"
var item_name="atenas spear bronze"
var itenGrabFrame=10
var descriptionPositive="+ 1 armor"
var descriptionNegative="- 2% move speed"

func addFunction():
	Global.player.armor+=1
	Global.player.moveSpeedPercentBonus-=0.02

func _ready():
	Global.ItemController.itenReadyFunction(self)
