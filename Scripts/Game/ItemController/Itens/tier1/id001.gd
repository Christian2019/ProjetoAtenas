extends Node2D

var id="001"
var item_name="AresShieldBronze"
var quality=0
var descriptionPositive="+ 2 Damage"
var descriptionNegative="- 1 Max hp"
var itenGrabFrame=0

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp-=1.0

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
