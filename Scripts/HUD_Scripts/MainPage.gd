extends Node2D


var pages;
var buttons;
var scrolls; 

var scrollxtreme = preload("res://Assets/Images/Store/ScrollExtreme.png")
var scrollGood = preload("res://Assets/Images/Store/ScrollGood.png")
var scrollLegendary = preload("res://Assets/Images/Store/ScrollLegendary.png")
var scrollNormal = preload("res://Assets/Images/Store/ScrollNormal.png")

var player = preload("res://Scripts/player.gd")

var random_value = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pages = [get_node("BG/SHOP"),get_node("BG/Mineração"),get_node("BG/Personagem"),get_node("BG/Defender Point")]
	buttons = [get_node("BG/MKenuMenu/Shop"),get_node("BG/MKenuMenu/Mineração"),get_node("BG/MKenuMenu/Personagem"),get_node("BG/MKenuMenu/Defender Point")]
	scrolls = [get_node("BG/SHOP/SCROLL1"),get_node("BG/SHOP/SCROLL2"),get_node("BG/SHOP/SCROLL3"),get_node("BG/SHOP/SCROLL4")]
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	get_node("BG/MKenuMenu/Shop").disabled=true;
	scrollsSelect()
	get_node("BG/MKenuMenu/Ouro").text="Gold:∞"
	get_node("BG/MKenuMenu/Wood").text=str("Wood:∞")
	get_node("BG/MKenuMenu/Stone").text= str("Stone:∞")
	
	pass # Replace with function body.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Adiciono aqui um valor aleatorio (Originalmente, adicionar a um objeto) 
func scrollsSelect():
	for i in range(0,len(buttons)):
		var type = random_value.randi_range(0,3)
		#var type = 0
		if(i>0):
			scrolls[i].get_node("Text").text="INDISPONÍVEL"
			scrolls[i].disabled=true
		
		if(type==0):
			scrolls[i].texture_normal=scrollNormal  
		elif(type==1):
			scrolls[i].texture_normal=scrollGood  
		elif(type==2):
			scrolls[i].texture_normal=scrollxtreme  
		elif(type==3):
			scrolls[i].texture_normal=scrollLegendary  

#AINDA EM DESENVOLVIMENTO, DEVO ENCONTRAR UMA FORMA MELHOR PRA FAZER ISSO KKKKKKK
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

func _on_minhas_coisas_pressed():
	$BG/SHOP/MINHAS_COISAS___TROCA/MINHASCOISAS.visible=true
	$BG/SHOP/MINHAS_COISAS___TROCA/TROCA.visible=false
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	$BG/SHOP/MINHAS_COISAS___TROCA/Troca.disabled=false 
	pass # Replace with function body.

func _on_troca_pressed(): 
	$BG/SHOP/MINHAS_COISAS___TROCA/MINHASCOISAS.visible=false
	$BG/SHOP/MINHAS_COISAS___TROCA/TROCA.visible=true
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=false
	$BG/SHOP/MINHAS_COISAS___TROCA/Troca.disabled=true 
	pass # Replace with function body.
