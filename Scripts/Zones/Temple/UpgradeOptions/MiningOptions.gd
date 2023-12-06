extends Control

@export var titulo = ""
@export var colorTitulo = Color()

@export var whatUpgrades = ""
@export var qtdDracma = 0
@export var qtdMinerios = 0 
@export var Minerio = ""

@export var mining_valor = 0.0
@export var bag_valor = 0.0
@export var texture_normal = Texture.new()
@export var texture_hover = Texture.new()

var qtd_ore_player
var gold
var stone
var wood

# Called when the node enters the scene tree for the first time.
func _ready():
	#Texturas Botão
	$Imagem.texture_normal = texture_normal
	$Imagem.texture_hover = texture_hover
	$Imagem.texture_pressed = texture_normal
	$Imagem.texture_disabled = texture_hover
	$Imagem.texture_focused = texture_hover
	
	verificaOre()
	#Texturas de minerios 
	$InfoDracma/Titulo.add_theme_color_override("font_color",colorTitulo)
	$InfoDracma/Titulo.text = titulo
	#Text
	get_node("InfoDracma/QtdDracma/Price").text = str(qtdDracma)
	if(whatUpgrades=="Power"):
		$InfoDracma/Upgrades/WhatUpgrades.text = "Power:"
		if(mining_valor > 0):  
			$InfoDracma/Upgrades/Ammount.text = "+"+str(mining_valor)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades/Ammount.text = "-"+str(mining_valor)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("ff0000"))
	elif(whatUpgrades=="Bag"):
		$InfoDracma/Upgrades/WhatUpgrades.text = "Bag:"
		if(bag_valor > 0):  
			$InfoDracma/Upgrades/Ammount.text = "+"+str(bag_valor)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades/Ammount.text = "-"+str(bag_valor)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("ff0000"))
	pass # Replace with function body.
 
func verificaOre():
	if(qtdMinerios>=0):  
			if(Minerio == "gold"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios) 
				pass
			elif(Minerio == "stone"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios) 
				pass
			elif(Minerio == "wood"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios) 
				pass
func _process(delta):
	if(Minerio == "gold"):
		qtd_ore_player = Global.player.gold
	elif(Minerio == "stone"):
		qtd_ore_player = Global.player.stone
	elif(Minerio == "wood"):
		qtd_ore_player = Global.player.wood
		
func decreaseOre():
		if(Minerio=="gold"):
			Global.player.gold -= qtdMinerios
		elif(Minerio == "stone"):
			Global.player.stone -= qtdMinerios
		elif(Minerio=="wood"):
			Global.player.wood -= qtdMinerios

func _on_botao_pressed():
	if(whatUpgrades=="Power"):   
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player): 
			get_parent().get_parent().current_level_Power+=1 
			Global.PlayerMining.damage_mining = mining_valor 
			Global.player.dracma -= qtdDracma
			decreaseOre()
			get_node("Aquired").visible=true
		else:
			turnOnWarning() 
			if(qtdDracma > Global.player.dracma):
				get_node("WarningSign/Warning").text = "You need more Dracmas"
			else: 
				if(Minerio == "gold"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more gold"
				elif(Minerio == "stone"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more stone"
				elif(Minerio == "wood"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more wood"
	elif(whatUpgrades=="Bag"):  
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_Bag+=1 
			Global.player.MaxCarriage = bag_valor   
			Global.player.dracma -= qtdDracma
			decreaseOre()
			get_node("Aquired").visible=true
		else:
			turnOnWarning() 
			if(qtdDracma > Global.player.dracma):
				get_node("WarningSign/Warning").text = "You need more Dracmas"
			else: 
				if(Minerio == "gold"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more gold"
				elif(Minerio == "stone"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more stone"
				elif(Minerio == "wood"):
					if(qtd_ore_player < qtdMinerios):
						get_node("WarningSign/Warning").text = "You need more wood"
	pass # Replace with function body.
	
func turnOnWarning():
	get_node("WarningSign").visible=true 
	$TurnOffWarning.start()

func turnOffWarning(): 
	get_node("WarningSign").visible=false
	
func _on_botao_mouse_entered():
	if($Imagem.disabled==false):
		$InfoDracma.visible = true
	else:
		$InfoDracma.visible = false 
	pass # Replace with function body.


func _on_botao_mouse_exited():
	get_node("InfoDracma").visible=false
	$NotAquired.visible=false
	pass # Replace with function body.


func _on_imagem_focus_entered():
	if($Imagem.disabled==false):
		$InfoDracma.visible = true
	else:
		if($Aquired.visible==false):
			$NotAquired.visible=true
		$InfoDracma.visible = false 
	pass # Replace with function body.


func _on_imagem_focus_exited():
	get_node("InfoDracma").visible=false 
	$NotAquired.visible=false
	pass # Replace with function body.


func _on_turn_off_warning_timeout():
	turnOffWarning()
	$TurnOffWarning.wait_time=0.2
	pass # Replace with function body.

 
