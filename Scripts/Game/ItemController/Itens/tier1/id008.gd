extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="008"
var item_name="ArtemisBow3"
var itenGrabFrame=7
var descriptionPositive="+ 2 Damage and +2 Max Hp"
var descriptionNegative="- 3% Attack Speed"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp+=2.0
	Global.player.attack_Speed-=0.03

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
