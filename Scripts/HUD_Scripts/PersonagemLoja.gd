extends Node2D


var itemsList;
var item = preload("res://Scenes/GameStore/Item.tscn")

func _ready():
	itemsList=$ITEMS/MyItems/Itens
	pass # Replace with function body.


func _process(delta):
	_my_Items()
	pass

func _my_Items(): 
	#Passar por um for para pegar info dos objetos comprados pelo player
	for i in 1:
		#PEGAR CENA
		var instance_of_object= item.instantiate()
		instance_of_object.position_board=$CaixasDeItem/Item1.position
		itemsList.add_child(item.instantiate())
		
