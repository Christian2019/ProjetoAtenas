extends Node2D

var id="005"
var item_name="AresShieldWood"
var quality=0
var descriptionPositive="+ 3 Max hp"
var descriptionNegative="- 1% Damage"
var itenGrabFrame=4

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=3.0
	Global.player.percentDamage-=0.01

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
