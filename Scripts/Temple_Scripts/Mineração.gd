extends Node2D

var upgrades_Power
var upgrades_IDK
var upgrades_LUCK

var current_level_Power = 0
var current_level_Luck = 0
var current_level_IDK = 0

func _ready():
	upgrades_Power = get_node("POWER").get_children()
	upgrades_LUCK = get_node("LUCK").get_children()
	upgrades_IDK = get_node("IDK").get_children()
	
func _process(delta): 
	
	if(current_level_Power<=4):
		for i in range(0,upgrades_Power.size()):
			if(current_level_Power == i):
				upgrades_Power[i].get_node("Imagem").disabled=false
			else:
				upgrades_Power[i].get_node("Imagem").disabled=true 
				
	if(current_level_Luck<=4): 
		for i in range(0,upgrades_LUCK.size()): 
			if(current_level_Luck == i):
				upgrades_LUCK[i].get_node("Imagem").disabled=false
			else:
				upgrades_LUCK[i].get_node("Imagem").disabled=true 
	if(current_level_IDK<=4):
		for i in range(0,upgrades_IDK.size()):
			if(current_level_IDK == i):
				upgrades_IDK[i].get_node("Imagem").disabled=false
			else:
				upgrades_IDK[i].get_node("Imagem").disabled=true 
	pass
