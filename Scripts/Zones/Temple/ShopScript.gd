extends Node2D




#SOMENTE PARA TESTE
var itens_personagem = []
#Listas de Itens
var listaItens 
var random_value = RandomNumberGenerator.new()

var lastItemClicked=0
var lastTextureClicked=Texture.new()

var scrolls; 

var attack1_itens
var attack2_itens
var torreta_itens
var dash_itens
var ultimate_itens
# Called when the node enters the scene tree for the first time.
func _ready():
	scrolls=$Botoes.get_children()   
	$MINHAS_COISAS___TROCA/MinhasCoisas.disabled=true
	for scoll in scrolls:
		scoll.disabled=false
		
	listaItens=get_node("ITEMS/ScrollContainer/Itens")
	
	#Area de itens
	attack1_itens = get_node("MINHAS_COISAS___TROCA/MINHASCOISAS/Attack1").get_children()
	attack2_itens = get_node("MINHAS_COISAS___TROCA/MINHASCOISAS/Attack2").get_children()
	torreta_itens = get_node("MINHAS_COISAS___TROCA/MINHASCOISAS/Torreta").get_children()
	dash_itens = get_node("MINHAS_COISAS___TROCA/MINHASCOISAS/Dash").get_children()
	ultimate_itens = get_node("MINHAS_COISAS___TROCA/MINHASCOISAS/Ultimate").get_children()
 
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
				scrolls[i].texture_normal = PreLoads.item_temple
				scrolls[i].texture_hover = PreLoads.item_hover
				scrolls[i].texture_pressed=PreLoads.item_temple 

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
	if(scrolls[0].texture_normal==PreLoads.item_temple):
		lastItemClicked=2
	else:
		lastItemClicked=1 
	$Warning.visible = true
	lastTextureClicked=scrolls[0].texture_normal
	pass # Replace with function body.

func _on_scroll_2_pressed():
	if(scrolls[1].texture_normal==PreLoads.item_temple):
		lastItemClicked=2
	else:
		lastItemClicked=1
	$Warning.visible = true  
	lastTextureClicked=scrolls[1].texture_normal
	pass # Replace with function body.

func _on_scroll_3_pressed():
	if(scrolls[2].texture_normal==PreLoads.item_temple):
		lastItemClicked=2
	else:
		lastItemClicked=1
	$Warning.visible = true  
	lastTextureClicked=scrolls[2].texture_normal
	pass # Replace with function body.

func _on_scroll_4_pressed():
	if(scrolls[3].texture_normal==PreLoads.item_temple):
		lastItemClicked=2
	else:
		lastItemClicked=1
	$Warning.visible = true  
	lastTextureClicked=scrolls[3].texture_normal
	pass # Replace with function body.

func addItemToAttack1(position): 
	attack1_itens[position].add_child(TextureRect.new())
	var last_child = attack1_itens[position].get_child(attack1_itens[position].get_child_count()-1)
	last_child.set_name("Item1")
	match(position):
		0:
			last_child.position.x = -10
			last_child.position.y=-12
			pass
		1:
			last_child.position.x = -5
			last_child.position.y=-12
			pass
		2:
			last_child.position.x = 0
			last_child.position.y=-12
			pass
	last_child.scale.x=0.14
	last_child.scale.y=0.14
	last_child.texture=lastTextureClicked

func addItemAttack2(position): 
	attack2_itens[position].add_child(TextureRect.new())
	var last_child = attack2_itens[position].get_child(attack2_itens[position].get_child_count()-1)
	last_child.set_name("Item1") 
	
	match(position):
		0:
			last_child.position.x = -10
			last_child.position.y = 15
			pass
		1:
			last_child.position.x = -5
			last_child.position.y = 15
			pass
		2:
			last_child.position.x = 0
			last_child.position.y = 15
			pass
	last_child.scale.x=0.14
	last_child.scale.y=0.14
	last_child.texture=lastTextureClicked

func addItemToTorreta(position): 
	torreta_itens[position].add_child(TextureRect.new())
	var last_child = torreta_itens[position].get_child(torreta_itens[position].get_child_count()-1)
	last_child.set_name("Item1")
	match(position):
		0:
			last_child.position.x = -10
			last_child.position.y = 35
			pass
		1:
			last_child.position.x = -5
			last_child.position.y = 35
			pass
		2:
			last_child.position.x = 0
			last_child.position.y = 35
			pass
	last_child.scale.x=0.14
	last_child.scale.y=0.14
	last_child.texture=lastTextureClicked 

func addItemToDash(position): 
	dash_itens[position].add_child(TextureRect.new())
	var last_child = dash_itens[position].get_child(dash_itens[position].get_child_count()-1)
	last_child.set_name("Item1")
	match(position):
		0:
			last_child.position.x = -10
			last_child.position.y=-58
			pass
		1:
			last_child.position.x = -5
			last_child.position.y=-58
			pass
		2:
			last_child.position.x = 0
			last_child.position.y=-58
			pass
	last_child.scale.x=0.14
	last_child.scale.y=0.14
	last_child.texture=lastTextureClicked 
	
func addItemToUltimate(position): 
	ultimate_itens[position].add_child(TextureRect.new())
	var last_child = ultimate_itens[position].get_child(ultimate_itens[position].get_child_count()-1)
	last_child.set_name("Item1")
	match(position):
		0:
			last_child.position.x = -10
			last_child.position.y=137
			pass
		1:
			last_child.position.x = -5
			last_child.position.y=137
			pass
		2:
			last_child.position.x = 0
			last_child.position.y=137
			pass
	last_child.scale.x=0.14
	last_child.scale.y=0.14
	last_child.texture=lastTextureClicked 
	
	
func _on_yes_pressed():
	$Warning.visible=false;
	#Desbloqueio/Adiociono Item X na lista 
	if(lastItemClicked==1): 
		var whereItenGoes = random_value.randi_range(0,4)
		#var whereItenGoes = 0
		if(whereItenGoes==0): 
			if(attack1_itens[0].has_node("Ativo_Spot")!=false):
				attack1_itens[0].get_node("Ativo_Spot").queue_free()
				addItemToAttack1(0)
			elif(attack1_itens[1].has_node("Passivo1_Spot")!=false):
				attack1_itens[1].get_node("Passivo1_Spot").queue_free()
				addItemToAttack1(1)
			elif(attack1_itens[2].has_node("Passivo2_Spot")!=false):
				attack1_itens[2].get_node("Passivo2_Spot").queue_free()
				addItemToAttack1(2)
		elif(whereItenGoes == 1):
			if(attack2_itens[0].has_node("Ativo_Spot")!=false):
				attack2_itens[0].get_node("Ativo_Spot").queue_free()
				addItemAttack2(0)
			elif(attack2_itens[1].has_node("Passivo1_Spot")!=false):
				attack2_itens[1].get_node("Passivo1_Spot").queue_free()
				addItemAttack2(1)
			elif(attack2_itens[2].has_node("Passivo2_Spot")!=false):
				attack2_itens[2].get_node("Passivo2_Spot").queue_free()
				addItemAttack2(2) 
		elif(whereItenGoes == 2):
			if(torreta_itens[0].has_node("Ativo_Spot")!=false):
				torreta_itens[0].get_node("Ativo_Spot").queue_free()
				addItemToTorreta(0)
			elif(torreta_itens[1].has_node("Passivo1_Spot")!=false):
				torreta_itens[1].get_node("Passivo1_Spot").queue_free()
				addItemToTorreta(1)
			elif(torreta_itens[2].has_node("Passivo2_Spot")!=false):
				torreta_itens[2].get_node("Passivo2_Spot").queue_free()
				addItemToTorreta(2)
			pass
		elif(whereItenGoes == 3):
			if(dash_itens[0].has_node("Ativo_Spot")!=false):
				dash_itens[0].get_node("Ativo_Spot").queue_free()
				addItemToDash(0)
			elif(dash_itens[1].has_node("Passivo1_Spot")!=false):
				dash_itens[1].get_node("Passivo1_Spot").queue_free()
				addItemToDash(1)
			elif(dash_itens[2].has_node("Passivo2_Spot")!=false):
				dash_itens[2].get_node("Passivo2_Spot").queue_free()
				addItemToDash(2)
			pass
		elif(whereItenGoes == 4):
			if(ultimate_itens[0].has_node("Ativo_Spot")!=false):
				ultimate_itens[0].get_node("Ativo_Spot").queue_free()
				addItemToUltimate(0)
			elif(ultimate_itens[1].has_node("Passivo1_Spot")!=false):
				ultimate_itens[1].get_node("Passivo1_Spot").queue_free()
				addItemToUltimate(1)
			elif(ultimate_itens[2].has_node("Passivo2_Spot")!=false):
				ultimate_itens[2].get_node("Passivo2_Spot").queue_free()
				addItemToUltimate(2)
			pass 
	elif(lastItemClicked==2):
		listaItens.add_child(TextureRect.new(),true)
		var last_child = listaItens.get_child(listaItens.get_child_count()-1)
		last_child.set_name("Item2");
		last_child.scale.x=0.15
		last_child.scale.y=0.15
		last_child.texture=lastTextureClicked 
		itens_personagem.append(lastItemClicked)

	
func _on_nope_pressed():
	$Warning.visible=false;

func _on_trade_20_stone_pressed():
	if(Global.player.gold>0):
		Global.player.gold-=1
		Global.player.stone+=25
	pass # Replace with function body.

func _on_trade_100_wood_pressed():
	if(Global.player.gold>0):
		Global.player.gold-=1
		Global.player.wood+=50
	pass # Replace with function body.


func _on_trade_1_gold_pressed():
	if(Global.player.stone>=25):
		Global.player.stone-=25
		Global.player.gold+=1
	pass # Replace with function body.


func _on_trade_50_wood_pressed():
	if(Global.player.stone>=5):
		Global.player.stone-=5
		Global.player.wood+=12
	pass # Replace with function body.


func _on_trade_wood_pressed():
	if(Global.player.wood>=50):
		Global.player.wood-=50
		Global.player.gold+=1
	pass # Replace with function body.
 
func _on_trade_wood_stone_pressed():
	if(Global.player.wood>=25):
		Global.player.wood-=25
		Global.player.stone+=1
	pass 
