extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="008"
var item_name="artemis bow 3"
var itenGrabFrame=7
var descriptionPositive="+ 2 damage and +2 max hp"
var descriptionNegative="- 3% attack speed"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.baseMaxHp+=2.0
	Global.player.attack_Speed-=0.03

func _ready():
	Global.ItemController.itenReadyFunction(self)
