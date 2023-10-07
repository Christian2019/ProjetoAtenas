extends Node2D


var itemsList;
var enteredSpot = 0 
var item = preload("res://Scenes/Temple/Item.tscn")

var upgrades_attack
var upgrades_defense

var current_level_attack = 0
var current_level_defense = 0

func _ready():
	upgrades_attack = get_node("Level Attack").get_children()
	upgrades_defense = get_node("Level Defesa").get_children()
	
func _process(delta): 
	if(current_level_attack<4):
		match(current_level_attack):
			0: 
				for i in range(1,upgrades_attack.size()):
					upgrades_attack[i].get_node("Imagem").disabled=true
				pass
			1: 
				upgrades_attack[0].get_node("Imagem").disabled=true 
				upgrades_attack[1].get_node("Imagem").disabled=false 
				for i in range(2,upgrades_attack.size()):
					upgrades_attack[i].get_node("Imagem").disabled=true
				pass
			2: 
				for i in range(0,2):
					upgrades_attack[i].get_node("Imagem").disabled=true 
				upgrades_attack[2].get_node("Imagem").disabled=false  
				for i in range(3,upgrades_attack.size()):
					upgrades_attack[i].get_node("Imagem").disabled=true
				pass
			3:
				for i in range(0,3):
					upgrades_attack[i].get_node("Imagem").disabled=true 
				upgrades_attack[3].get_node("Imagem").disabled=false  
				for i in range(4,upgrades_attack.size()):
					upgrades_attack[i].get_node("Imagem").disabled=true
				pass 
				
	if(current_level_defense<4):
		match(current_level_defense):
			0: 
				for i in range(1,upgrades_defense.size()):
					upgrades_defense[i].get_node("Imagem").disabled=true
				pass
			1: 
				upgrades_defense[0].get_node("Imagem").disabled=true 
				upgrades_defense[1].get_node("Imagem").disabled=false 
				for i in range(2,upgrades_defense.size()):
					upgrades_defense[i].get_node("Imagem").disabled=true
				pass
			2: 
				for i in range(0,2):
					upgrades_defense[i].get_node("Imagem").disabled=true 
				upgrades_defense[2].get_node("Imagem").disabled=false  
				for i in range(3,upgrades_defense.size()):
					upgrades_defense[i].get_node("Imagem").disabled=true
				pass
			3:
				for i in range(0,3):
					upgrades_defense[i].get_node("Imagem").disabled=true 
				upgrades_defense[3].get_node("Imagem").disabled=false  
				for i in range(4,upgrades_defense.size()):
					upgrades_defense[i].get_node("Imagem").disabled=true
				pass 
	pass

func _on_yes_pressed():
	$Warning2.visible=false 
	pass # Replace with function body.


func _on_nope_pressed():
	$Warning2.visible=false
	pass # Replace with function body.


 
