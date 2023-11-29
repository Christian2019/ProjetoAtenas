extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="019"
var itenGrabFrame=18
var item_name="DemetersCiferMetal"
var descriptionPositive="+ 10% Luck"
var descriptionNegative="- 2% Damage"

func addFunction():
	Global.player.luck+=0.1
	Global.player.percentDamage-=0.02

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
