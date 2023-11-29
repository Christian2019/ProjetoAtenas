extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="020"
var itenGrabFrame=19
var item_name="DemetersCiferSilver"
var descriptionPositive="+ 4% Move Speed"
var descriptionNegative="- 6% Luck"

func addFunction():
	Global.player.luck-=0.06
	Global.player.moveSpeedPercentBonus+=0.04

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
