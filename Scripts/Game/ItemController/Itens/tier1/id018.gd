extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="018"
var itenGrabFrame=17
var item_name="demeters cifer gold"
var descriptionPositive="+ 3 hp regen"
var descriptionNegative="- 1% life steal"

func addFunction():
	Global.player.hpRegeneration+=3
	Global.player.lifeStealChance-=0.01

func _ready():
	Global.ItemController.itenReadyFunction(self)
