extends Node2D

var upgrades_Power
var upgrades_BAG 

var current_level_Power = 0
var current_level_Bag = 0 

func _ready():
	upgrades_Power = get_node("POWER").get_children()
	upgrades_BAG = get_node("BAG").get_children() 
	
func _process(delta): 
	
	if(current_level_Power<=4):
		for i in range(0,upgrades_Power.size()):
			if(current_level_Power == i):
				upgrades_Power[i].get_node("Imagem").disabled=false
			else:
				upgrades_Power[i].get_node("Imagem").disabled=true 
				
	if(current_level_Bag<=4): 
		for i in range(0,upgrades_BAG.size()): 
			if(current_level_Bag == i):
				upgrades_BAG[i].get_node("Imagem").disabled=false
			else:
				upgrades_BAG[i].get_node("Imagem").disabled=true 
	pass
