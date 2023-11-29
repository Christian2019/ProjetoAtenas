extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="006"
var item_name="artemis bow 1"
var itenGrabFrame=5
var descriptionPositive="+ 1 damage and +3% crit"
var descriptionNegative="- 1 max hp"

func addFunction():
	Global.player.baseDamage+=1.0
	Global.player.percentCritDamage+=0.03
	Global.player.baseMaxHp-=1.0

func _ready():
	Global.ItemController.itenReadyFunction(self)
