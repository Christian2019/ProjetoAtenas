extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="006"
var item_name="ArtemisBow1"
var itenGrabFrame=5
var descriptionPositive="+ 1 Damage and +3% Crit"
var descriptionNegative="- 1 Max hp"

func addFunction():
	Global.player.baseDamage+=1.0
	Global.player.percentCritDamage+=0.03
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
