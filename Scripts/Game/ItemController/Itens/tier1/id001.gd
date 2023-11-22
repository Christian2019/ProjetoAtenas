extends Node2D

var id="001"
var item_name="Grape"
var quality=0
var descriptionPositive="+ 2 Damage"
var descriptionNegative="- 1 Max hp"

func ready():
	$item_name.text=item_name
	$descriptionPositive.text=descriptionPositive
	$descriptionNegative.text=descriptionNegative
	$Quality.get_child(quality).visible=true
	

func addFunction():
	Global.ItemController.appendItem(self)
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp-=1.0
