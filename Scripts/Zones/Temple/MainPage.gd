extends Node2D


var pages;
var buttons; 
 
func _ready(): 
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$BG/MenuPrincipal/Abas/Shop.grab_focus()
	Global.TempleScreen = self  
	pages = [get_node("BG/SHOP"),get_node("BG/Mineração"),get_node("BG/Personagem"),get_node("BG/Defender Point")]
	buttons = $BG/MenuPrincipal/Abas.get_children() 
	get_node("BG/MenuPrincipal/Abas/Shop").disabled=true;  
	
func _process(delta):   
	get_node("BG/MenuPrincipal/Labels/Ouro").text=str("Gold: ",Global.player.gold)
	get_node("BG/MenuPrincipal/Labels/Wood").text=str("Wood: ",Global.player.wood)
	get_node("BG/MenuPrincipal/Labels/Stone").text= str("Stone: ",Global.player.stone)  
	if Input.is_action_just_pressed("Exit"): 
		get_tree().paused = false
		visible=false
  
func transition(numPage): 
	for i in range(0,len(pages)):
		if(i==numPage-1):
			pages[i].visible=true
			buttons[i].disabled=true
		else:
			pages[i].visible=false
			buttons[i].disabled=false

func _on_shop_pressed():
	#Paginas devem fazer a transicao aqui
	transition(1) 

func _on_mineração_pressed():
	#Paginas devem fazer a transicao aqui
	transition(2) 

func _on_personagem_pressed():
	#Paginas devem fazer a transicao aqui
	transition(3) 

func _on_defender_point_pressed():
	#Paginas devem fazer a transicao aqui
	transition(4)   


 
