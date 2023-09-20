extends Node2D


var pages;
var buttons;
var scrolls; 

#Texture
var scrollxtreme = preload("res://Assets/Images/Store/ScrollExtreme.png")
var scrollxtremeHover = preload("res://Assets/Images/Store/ScrollExtremeHover.png")
var scrollGood = preload("res://Assets/Images/Store/ScrollGood.png")
var scrollGoodHover = preload("res://Assets/Images/Store/ScrollGoodHover.png")
var scrollLegendary = preload("res://Assets/Images/Store/ScrollLegendary.png")
var scrollLegendaryHover = preload("res://Assets/Images/Store/ScrollLegendaryHover.png")
var scrollNormal = preload("res://Assets/Images/Store/ScrollNormal.png")
var scrollNormalHover = preload("res://Assets/Images/Store/ScrollNormalHover.png")
var item = preload("res://Assets/Images/Store/RockItem.png")
var item_hover = preload("res://Assets/Images/Store/RockItemHover.png")

#Player
var player = preload("res://Scripts/player.gd")

#LastItemClicked
var lastItemClicked = 0


#SOMENTE PARA TESTE
var itens_personagem = []
#Listas de Itens
var listaItens
var minhascoisas_Lista
var random_value = RandomNumberGenerator.new()


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	Global.Temple = self
	pages = [get_node("BG/SHOP"),get_node("BG/Mineração"),get_node("BG/Personagem"),get_node("BG/Defender Point")]
	buttons = [get_node("BG/MKenuMenu/Shop"),get_node("BG/MKenuMenu/Mineração"),get_node("BG/MKenuMenu/Personagem"),get_node("BG/MKenuMenu/Defender Point")]
	scrolls = [get_node("BG/SHOP/SCROLL1"),get_node("BG/SHOP/SCROLL2"),get_node("BG/SHOP/SCROLL3"),get_node("BG/SHOP/SCROLL4")]
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	get_node("BG/MKenuMenu/Shop").disabled=true;
	scrollsSelect()
	get_node("BG/MKenuMenu/Ouro").text="Gold:∞"
	get_node("BG/MKenuMenu/Wood").text=str("Wood:∞")
	get_node("BG/MKenuMenu/Stone").text= str("Stone:∞")
	
	minhascoisas_Lista=get_node("BG/SHOP/MINHAS_COISAS___TROCA/MINHASCOISAS/ScrollContainer/Itens")
	listaItens = get_node("BG/SHOP/ITEMS/ScrollContainer/Itens")

func _process(delta):
	if Input.is_action_just_pressed("Exit"):
			get_tree().paused = false
			visible=false

#Adiciono aqui um valor aleatorio (Originalmente, adicionar a um objeto) 
func scrollsSelect():
	for i in range(0,len(buttons)): 
		var type = random_value.randi_range(0,3)
		if(i==0):
			scrolls[i].texture_normal= scrollNormal
			scrolls[i].texture_hover=scrollNormalHover
			scrolls[i].texture_pressed= scrollNormal
			scrolls[i].texture_disabled=scrollNormalHover
		elif(i==1):
			scrolls[i].texture_normal= item
			scrolls[i].texture_hover=item_hover
			scrolls[i].texture_pressed= item
			scrolls[i].texture_disabled=item_hover
		else:
			if(i>1):
				scrolls[i].get_node("Text").text="INDISPONÍVEL"
				scrolls[i].disabled=true
				
			if(type==0):
				scrolls[i].texture_normal=scrollNormal  
				scrolls[i].texture_hover=scrollNormalHover 
				scrolls[i].texture_pressed = scrollNormal
			elif(type==1):
				scrolls[i].texture_normal=scrollGood  
				scrolls[i].texture_hover=scrollGoodHover
				scrolls[i].texture_pressed = scrollGood
			elif(type==2):
				scrolls[i].texture_normal=scrollxtreme  
				scrolls[i].texture_hover=scrollxtremeHover
				scrolls[i].texture_pressed = scrollxtreme
			elif(type==3):
				scrolls[i].texture_normal=scrollLegendary  
				scrolls[i].texture_hover=scrollLegendaryHover  
				scrolls[i].texture_pressed = scrollLegendary 
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


func _on_mineração_pressed():
	#Paginas devem fazer a transicao aqui
	transition(2) 


func _on_personagem_pressed():
	#Paginas devem fazer a transicao aqui
	transition(3) 


func _on_defender_point_pressed():
	#Paginas devem fazer a transicao aqui
	transition(4) 


func _on_minhas_coisas_pressed():
	$BG/SHOP/MINHAS_COISAS___TROCA/MINHASCOISAS.visible=true
	$BG/SHOP/MINHAS_COISAS___TROCA/TROCA.visible=false
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	$BG/SHOP/MINHAS_COISAS___TROCA/Troca.disabled=false 


func _on_troca_pressed(): 
	$BG/SHOP/MINHAS_COISAS___TROCA/MINHASCOISAS.visible=false
	$BG/SHOP/MINHAS_COISAS___TROCA/TROCA.visible=true
	$BG/SHOP/MINHAS_COISAS___TROCA/MinhasCoisas.disabled=false
	$BG/SHOP/MINHAS_COISAS___TROCA/Troca.disabled=true 



func _on_scroll_1_pressed():
	$Warning.visible = true
	lastItemClicked=1

 

func _on_scroll_2_pressed():
	$Warning.visible = true
	lastItemClicked=2 


func _on_yes_pressed():
	$Warning.visible=false;
	#Desbloqueio/Adiociono Item X na lista 
	if(lastItemClicked==1): 
		minhascoisas_Lista.add_child(TextureRect.new(),true)
		var last_child = minhascoisas_Lista.get_child(listaItens.get_child_count()-1)
		last_child.set_name("Item1");
		last_child.texture=load("res://icon.png")
		scrolls[lastItemClicked-1].disabled=true;
	elif(lastItemClicked==2):
		listaItens.add_child(TextureRect.new(),true)
		var last_child = listaItens.get_child(minhascoisas_Lista.get_child_count()-1)
		last_child.set_name("Item2");
		last_child.texture=load("res://icon.png")
		scrolls[lastItemClicked-1].disabled=true;
		itens_personagem.append(lastItemClicked)

	
func _on_nope_pressed():
	$Warning.visible=false;


