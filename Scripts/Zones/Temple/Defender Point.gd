extends Node2D

var upgrades_centro
var upgrades_sentinela
var upgrades_piscina

var current_level_centro = 0
var current_level_piscina = 0
var current_level_sentinela = 0

func _ready():
	upgrades_centro = get_node("Centro").get_children()
	upgrades_piscina = get_node("Piscina").get_children()
	upgrades_sentinela = get_node("Sentinela").get_children()
	
func _process(delta): 
	if(current_level_centro<4):
		for i in range(0,upgrades_centro.size()):
			if(current_level_centro == i):
				upgrades_centro[i].get_node("Imagem").disabled=false
			else:
				upgrades_centro[i].get_node("Imagem").disabled=true 
				
	if(current_level_piscina<4):
		for i in range(0,upgrades_piscina.size()):
			if(current_level_piscina == i):
				upgrades_piscina[i].get_node("Imagem").disabled=false
			else:
				upgrades_piscina[i].get_node("Imagem").disabled=true 
				
	if(current_level_sentinela<4):
		for i in range(0,upgrades_sentinela.size()):
			if(current_level_sentinela == i):
				upgrades_sentinela[i].get_node("Imagem").disabled=false
			else:
				upgrades_sentinela[i].get_node("Imagem").disabled=true 
	pass
