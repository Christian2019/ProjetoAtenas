extends Node2D

#Item value
var wood =0
var stone =0
var gold =0

var quality=0
var id="006"
var item_name="artemis bow 1"
var itenGrabFrame=5
var descriptionPositive="+ "+ str(AllSkillsValues.damage) +" damage and +"+ str(int(AllSkillsValues.percentCritDamage*100)) +"% crit"
var descriptionNegative="- "+ str(AllSkillsValues.hp/3) +" max hp"

func addFunction():
	Global.player.baseDamage+=AllSkillsValues.damage
	Global.player.percentCritDamage+=AllSkillsValues.percentCritDamage
	Global.player.baseMaxHp-=AllSkillsValues.hp/3

func _ready():
	Global.ItemController.itenReadyFunction(self)
