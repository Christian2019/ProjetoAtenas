extends Node2D

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
	print(Minerio)
	#Texturas Botão
	$Imagem.texture_normal = texture_normal
	$Imagem.texture_hover = texture_hover
	$Imagem.texture_disabled = texture_hover
	$Imagem.texture_focused = texture_hover
	
	verificaOre()
	#Texturas de minerios
	gold = load("res://Assets/Images/HUD/Loja/Gold.png")
	stone = load("res://Assets/Images/HUD/Loja/Rock.png")
	wood = load("res://Assets/Images/HUD/Loja/Wood.png")
	
	
	#Text
	get_node("InfoDracma/QtdDracma/Price").text = str(qtdDracma)
	if(qtd_ore_player==0 or qtd_ore_player == null):
		$InfoDracma/QtdMinerio.visible = false
	pass # Replace with function body.

func verificaOre():
	if(qtdMinerios>0): 
			if(Minerio == "gold"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios)
				qtd_ore_player = Global.player.gold
				pass
			elif(Minerio == "stone"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios)
				qtd_ore_player = Global.player.stone
				pass
			elif(Minerio == "wood"):
				get_node("InfoDracma/QtdMinerio/Minerio").animation = Minerio
				get_node("InfoDracma/QtdMinerio/Price").text = str(qtdMinerios)
				qtd_ore_player = Global.player.wood 
				pass

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
	elif(whatUpgrades=="Bag"):  
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_Bag+=1 
			Global.player.MaxCarriage = bag_valor   
			Global.player.dracma -= qtdDracma
			decreaseOre()
			get_node("Aquired").visible=true
	pass # Replace with function body.


func _on_botao_mouse_entered():
	get_node("InfoDracma").visible=true
	pass # Replace with function body.


func _on_botao_mouse_exited():
	get_node("InfoDracma").visible=false
	pass # Replace with function body.
