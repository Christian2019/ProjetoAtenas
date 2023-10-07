extends Node2D

var upgrades_maxHP
var upgrades_HealthDelay

var current_level_MaxHP = 0
var current_level_HealthDelay = 0

func _ready():
	upgrades_maxHP = get_node("MaxHP").get_children()
	upgrades_HealthDelay = get_node("Health Delay").get_children()
	
func _process(delta): 
	if(current_level_MaxHP<4):
		match(current_level_MaxHP):
			0: 
				for i in range(1,upgrades_maxHP.size()):
					upgrades_maxHP[i].get_node("Imagem").disabled=true
				pass
			1: 
				upgrades_maxHP[0].get_node("Imagem").disabled=true 
				upgrades_maxHP[1].get_node("Imagem").disabled=false 
				for i in range(2,upgrades_maxHP.size()):
					upgrades_maxHP[i].get_node("Imagem").disabled=true
				pass
			2: 
				for i in range(0,2):
					upgrades_maxHP[i].get_node("Imagem").disabled=true 
				upgrades_maxHP[2].get_node("Imagem").disabled=false  
				for i in range(3,upgrades_maxHP.size()):
					upgrades_maxHP[i].get_node("Imagem").disabled=true
				pass
			3:
				for i in range(0,3):
					upgrades_maxHP[i].get_node("Imagem").disabled=true 
				upgrades_maxHP[3].get_node("Imagem").disabled=false  
				for i in range(4,upgrades_maxHP.size()):
					upgrades_maxHP[i].get_node("Imagem").disabled=true
				pass 
				
	if(current_level_HealthDelay<4):
		match(current_level_HealthDelay):
			0: 
				for i in range(1,upgrades_HealthDelay.size()):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true
				pass
			1: 
				upgrades_HealthDelay[0].get_node("Imagem").disabled=true 
				upgrades_HealthDelay[1].get_node("Imagem").disabled=false 
				for i in range(2,upgrades_HealthDelay.size()):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true
				pass
			2: 
				for i in range(0,2):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true 
				upgrades_HealthDelay[2].get_node("Imagem").disabled=false  
				for i in range(3,upgrades_HealthDelay.size()):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true
				pass
			3:
				for i in range(0,3):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true 
				upgrades_HealthDelay[3].get_node("Imagem").disabled=false  
				for i in range(4,upgrades_HealthDelay.size()):
					upgrades_HealthDelay[i].get_node("Imagem").disabled=true
				pass 
	pass
