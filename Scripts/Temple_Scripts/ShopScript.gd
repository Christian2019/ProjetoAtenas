extends Node2D




#SOMENTE PARA TESTE
var itens_personagem = []
#Listas de Itens
var listaItens
var minhascoisas_Lista
var random_value = RandomNumberGenerator.new()

var lastItemClicked=0
var scrolls; 
# Called when the node enters the scene tree for the first time.
func _ready():
	scrolls=$Botoes.get_children()   
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	pass # Replace with function body.

#Adiciono aqui um valor aleatorio (Originalmente, adicionar a um objeto) 
func scrollsSelect():
	for i in range(0,len(scrolls)): 
		var type = random_value.randi_range(0,4)
		match type:
			0:
				scrolls[i].texture_normal=PreLoads.scrollNormal  
				scrolls[i].texture_hover=PreLoads.scrollNormalHover 
				scrolls[i].texture_pressed = PreLoads.scrollNormal
			1:
				scrolls[i].texture_normal=PreLoads.scrollGood  
				scrolls[i].texture_hover=PreLoads.scrollGoodHover
				scrolls[i].texture_pressed = PreLoads.scrollGood
			2:
				scrolls[i].texture_normal=PreLoads.scrollxtreme  
				scrolls[i].texture_hover=PreLoads.scrollxtremeHover
				scrolls[i].texture_pressed = PreLoads.scrollxtreme
			3:
				scrolls[i].texture_normal= PreLoads.scrollLegendary  
				scrolls[i].texture_hover=PreLoads.scrollLegendaryHover  
				scrolls[i].texture_pressed = PreLoads.scrollLegendary
			4:
				scrolls[i].texture_normal = PreLoads.item
				scrolls[i].texture_hover = PreLoads.item_hover
				scrolls[i].texture_pressed=PreLoads.item 

func _on_minhas_coisas_pressed():
	$MINHAS_COISAS___TROCA/MINHASCOISAS.visible=true
	$MINHAS_COISAS___TROCA/TROCA.visible=false
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	$MINHAS_COISAS___TROCA/Troca.disabled=false 

func _on_troca_pressed(): 
	$MINHAS_COISAS___TROCA/MINHASCOISAS.visible=false
	$MINHAS_COISAS___TROCA/TROCA.visible=true
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=false
	$MINHAS_COISAS___TROCA/Troca.disabled=true 

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

func _on_trade_20_stone_pressed():
	if(Global.player.gold>0):
		Global.player.gold-=1
		Global.player.stone+=20
	pass # Replace with function body.

func _on_trade_100_wood_pressed():
	if(Global.player.gold>0):
		Global.player.gold-=1
		Global.player.wood+=100
	pass # Replace with function body.


func _on_trade_1_gold_pressed():
	if(Global.player.stone>=20):
		Global.player.stone-=20
		Global.player.gold+=1
	pass # Replace with function body.


func _on_trade_50_wood_pressed():
	if(Global.player.stone>0):
		Global.player.stone-=1
		Global.player.wood+=50
	pass # Replace with function body.


func _on_trade_wood_pressed():
	if(Global.player.wood>=100):
		Global.player.wood-=100
		Global.player.gold+=1
	pass # Replace with function body.
 
func _on_trade_wood_stone_pressed():
	if(Global.player.wood>=50):
		Global.player.wood-=50
		Global.player.stone+=1
	pass 
