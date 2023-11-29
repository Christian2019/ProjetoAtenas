extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="010"
var item_name="ArtemisBow5"
var itenGrabFrame=9
var descriptionPositive="+ 3 Damage"
var descriptionNegative="- 2% Crit"

func addFunction():
	Global.player.baseDamage+=3.0
	Global.player.percentCritDamage-=0.02

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
