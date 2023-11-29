extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="015"
var itenGrabFrame=14
var item_name="AtenasSpearWood"
var descriptionPositive="+ 3 Hp Regen"
var descriptionNegative="- 2% Luck"

func addFunction():
	Global.player.hpRegeneration+=3
	Global.player.luck-=0.02

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
