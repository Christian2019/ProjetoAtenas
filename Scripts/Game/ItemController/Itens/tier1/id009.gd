extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="009"
var item_name="ArtemisBow4"
var itenGrabFrame=8
var descriptionPositive="+ 1 Armor and +1 Damage"
var descriptionNegative="- 2 Max Hp"

func addFunction():
	Global.player.baseDamage+=1.0
	Global.player.armor+=1
	Global.player.baseMaxHp-=2.0

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
