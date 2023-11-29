extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="017"
var itenGrabFrame=16
var item_name="DemetersCiferDiamond"
var descriptionPositive="+ 2 Damage"
var descriptionNegative="- 1% Attack Speed and 1% Crit"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.attack_Speed-=0.01
	Global.player.percentCritDamage-=0.01

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
