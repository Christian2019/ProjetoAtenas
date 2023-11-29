extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="016"
var itenGrabFrame=15
var item_name="DemetersCiferBronze"
var descriptionPositive="+ 2 Damage"
var descriptionNegative="- 3% Move Speed"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.moveSpeedPercentBonus-=0.03

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
