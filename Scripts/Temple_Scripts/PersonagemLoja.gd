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
	if(current_level_attack<=4):
		for i in range(0,upgrades_attack.size()):
			if(current_level_attack == i):
				upgrades_attack[i].get_node("Imagem").disabled=false
			else:
				upgrades_attack[i].get_node("Imagem").disabled=true  
				
	if(current_level_defense<=4):
		for i in range(0,upgrades_defense.size()):
			if(current_level_defense == i):
				upgrades_defense[i].get_node("Imagem").disabled=false
			else:
				upgrades_defense[i].get_node("Imagem").disabled=true  

func _on_yes_pressed():
	$Warning2.visible=false 
	pass # Replace with function body.


func _on_nope_pressed():
	$Warning2.visible=false
	pass # Replace with function body.


 
