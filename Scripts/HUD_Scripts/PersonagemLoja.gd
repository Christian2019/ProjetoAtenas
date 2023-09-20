extends Node2D


var itemsList;
var enteredSpot = 0 
var item = preload("res://Scenes/GameStore/Item.tscn")

func _ready():
	itemsList=$ITEMS/MyItems/Itens
	pass # Replace with function body.


func _process(delta): 
	if(enteredSpot==1):
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			$Warning2.visible=true;
	pass
 

func _on_item_1_mouse_entered(): 
	enteredSpot=1
	pass # Replace with function body.


func _on_yes_pressed():
	$Warning2.visible=false
	$CaixasDeItem/Item1/ColorRect.color=Color.ORANGE_RED
	pass # Replace with function body.


func _on_nope_pressed():
	$Warning2.visible=false
	pass # Replace with function body.


func _on_item_1_mouse_exited():
	enteredSpot=0
	pass # Replace with function body.
