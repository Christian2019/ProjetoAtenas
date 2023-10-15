extends Node2D

var upgrades_maxHP
var upgrades_HealthDelay

var current_level_MaxHP = 0
var current_level_HealthDelay = 0

func _ready():
	upgrades_maxHP = get_node("MaxHP").get_children()
	upgrades_HealthDelay = get_node("Health Delay").get_children()
	
func _process(delta): 
	if(current_level_MaxHP<=4):
		for i in range(0,upgrades_maxHP.size()):
			if(current_level_MaxHP == i):
				upgrades_maxHP[i].get_node("Imagem").disabled=false
			else:
				upgrades_maxHP[i].get_node("Imagem").disabled=true 
				
	if(current_level_HealthDelay<=4):
		for i in range(0,upgrades_HealthDelay.size()):
			if(current_level_HealthDelay == i):
				upgrades_HealthDelay[i].get_node("Imagem").disabled=false
			else:
				upgrades_HealthDelay[i].get_node("Imagem").disabled=true 
	pass
