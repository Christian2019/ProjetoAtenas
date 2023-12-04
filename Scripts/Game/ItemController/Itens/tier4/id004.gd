extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=3
var id="004"
var itenGrabFrame=48
var item_name="zeus thunder 4"
var descriptionPositive="+ 20 damage and + 5 hp regen"
var descriptionNegative="- 8% damage and - 3% move speed"

func addFunction():
	Global.player.baseDamage+=20.0
	Global.player.hpRegeneration+=5
	Global.player.moveSpeedPercentBonus-=0.03
	Global.player.percentDamage-=0.08

func _ready():
	Global.ItemController.itenReadyFunction(self)
