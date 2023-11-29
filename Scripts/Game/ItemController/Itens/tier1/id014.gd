extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="014"
var itenGrabFrame=13
var item_name="AtenasSpearSilver"
var descriptionPositive="+ 10% Luck"
var descriptionNegative="- 1 Damage"

func addFunction():
	Global.player.luck+=0.1
	Global.player.baseDamage-=1.0

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
