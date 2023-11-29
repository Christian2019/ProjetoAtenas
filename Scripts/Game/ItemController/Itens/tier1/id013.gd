extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="013"
var itenGrabFrame=12
var item_name="AtenasSpearGold"
var descriptionPositive="+ 6% Crit"
var descriptionNegative="- 3% Damage"

func addFunction():
	Global.player.percentCritDamage+=0.06
	Global.player.percentDamage-=0.03

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
