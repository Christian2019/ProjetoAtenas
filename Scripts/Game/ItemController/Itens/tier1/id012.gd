extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="012"
var itenGrabFrame=11
var item_name="AtenasSpearDiamond"
var descriptionPositive="+ 7% Damage"
var descriptionNegative="- 2 Max Hp"

func addFunction():
	Global.player.percentDamage+=0.07
	Global.player.baseMaxHp-=2.0

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
