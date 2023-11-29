extends Node2D

var id="002"
var item_name="AresShieldGold"
var quality=0
var descriptionPositive="+ 1 Damage"
var descriptionNegative=""
var itenGrabFrame=1

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseDamage+=1.0

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
