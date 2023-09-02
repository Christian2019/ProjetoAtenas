extends Node2D


var pages;
# Called when the node enters the scene tree for the first time.
func _ready():
	pages = [get_node("BG/SHOP"),get_node("BG/Mineração"),get_node("BG/Personagem"),get_node("BG/Defender Point")]
	get_node("BG/MKenuMenu/Shop").disabled=true;
	pass # Replace with function body.1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#AINDA EM DESENVOLVIMENTO, DEVO ENCONTRAR UMA FORMA MELHOR PRA FAZER ISSO KKKKKKK
func transition(numPage):
	if(numPage==1):
		pages[0].visible=true;
		pages[1].visible=false;
		pages[2].visible=false;
		pages[3].visible=false;
		
		#Aqui ativo e desativo os demais botoes
		get_node("BG/MKenuMenu/Shop").disabled=true;
		get_node("BG/MKenuMenu/Mineração").disabled=false;
		get_node("BG/MKenuMenu/Personagem").disabled=false;
		get_node("BG/MKenuMenu/Defender Point").disabled=false;
	elif(numPage==2):
		pages[0].visible=false;
		pages[1].visible=true;
		pages[2].visible=false;
		pages[3].visible=false;
		
		#Aqui ativo e desativo os demais botoes
		get_node("BG/MKenuMenu/Shop").disabled=false;
		get_node("BG/MKenuMenu/Mineração").disabled=true;
		get_node("BG/MKenuMenu/Personagem").disabled=false;
		get_node("BG/MKenuMenu/Defender Point").disabled=false;
	elif(numPage==3):
		pages[0].visible=false;
		pages[1].visible=false;
		pages[2].visible=true;
		pages[3].visible=false;
		
		#Aqui ativo e desativo os demais botoes
		get_node("BG/MKenuMenu/Shop").disabled=false;
		get_node("BG/MKenuMenu/Mineração").disabled=false;
		get_node("BG/MKenuMenu/Personagem").disabled=true;
		get_node("BG/MKenuMenu/Defender Point").disabled=false;
	elif(numPage==4):
		pages[0].visible=false;
		pages[1].visible=false;
		pages[2].visible=false;
		pages[3].visible=true;
		
		#Aqui ativo e desativo os demais botoes
		get_node("BG/MKenuMenu/Shop").disabled=false;
		get_node("BG/MKenuMenu/Mineração").disabled=false;
		get_node("BG/MKenuMenu/Personagem").disabled=false;
		get_node("BG/MKenuMenu/Defender Point").disabled=true;
		

func _on_shop_pressed():
	#Paginas devem fazer a transicao aqui
	transition(1) 
	pass # Replace with function body.


func _on_mineração_pressed():
	#Paginas devem fazer a transicao aqui
	transition(2) 
	pass # Replace with function body.


func _on_personagem_pressed():
	#Paginas devem fazer a transicao aqui
	transition(3) 
	pass # Replace with function body.


func _on_defender_point_pressed():
	#Paginas devem fazer a transicao aqui
	transition(4) 
	pass # Replace with function body.
