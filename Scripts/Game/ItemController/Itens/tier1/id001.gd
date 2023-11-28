extends Node2D

var id="001"
var item_name="AresShieldBronze"
var quality=0
var descriptionPositive="+ 2 Damage"
var descriptionNegative="- 1 Max hp"
var itenGrabFrame=0

#Item value
var wood =10
var stone =0
var gold =0

func ready():
	$item_name.text=item_name
	$descriptionPositive.text=descriptionPositive
	$descriptionNegative.text=descriptionNegative
	$Quality.frame=quality
	$ItemGrab.get_node("Itens").frame=itenGrabFrame
	

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp-=1.0
