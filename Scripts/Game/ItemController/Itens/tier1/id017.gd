extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="017"
var itenGrabFrame=16
var item_name="demeters cifer diamond"
var descriptionPositive="+ 2 damage"
var descriptionNegative="- 1% attack speed and 1% crit"

func addFunction():
	Global.player.baseDamage+=2.0
	Global.player.attack_Speed-=0.01
	Global.player.percentCritDamage-=0.01

func _ready():
	Global.ItemController.itenReadyFunction(self)
