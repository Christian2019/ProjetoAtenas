extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="018"
var itenGrabFrame=17
var item_name="DemetersCiferGold"
var descriptionPositive="+ 3 Hp Regen"
var descriptionNegative="- 1% Life Steal"

func addFunction():
	Global.player.hpRegeneration+=3
	Global.player.lifeStealChance-=0.01

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
