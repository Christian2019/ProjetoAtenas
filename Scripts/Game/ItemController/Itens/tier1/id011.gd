extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="011"
var item_name="AtenasSpearBronze"
var itenGrabFrame=10
var descriptionPositive="+ 1 Armor"
var descriptionNegative="- 2% Move Speed"

func addFunction():
	Global.player.armor+=1
	Global.player.moveSpeedPercentBonus-=0.02

func ready():
	$item_name.text=item_name
	$descriptionPositive.text=descriptionPositive
	$descriptionNegative.text=descriptionNegative
	$Quality.frame=quality
	$ItemGrab.get_node("Itens").frame=itenGrabFrame
	var resources=Global.ItemController.getRandomValue(quality)
	wood=resources.wood
	stone=resources.stone
	gold=resources.gold
