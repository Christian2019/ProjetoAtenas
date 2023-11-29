extends Node2D

var id="003"
var item_name="AresShieldRock"
var quality=0
var descriptionPositive="+ 5 Max hp"
var descriptionNegative="- 1 Hp Regen"
var itenGrabFrame=2

#Item value
var wood =0
var stone =0
var gold =0

func addFunction():
	Global.player.baseMaxHp+=5.0
	Global.player.hpRegeneration-=1

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
