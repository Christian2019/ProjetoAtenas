extends Control

@export var titulo = ""
@export var colorTitulo = Color()

@export var whatUpgrades = ""
@export var qtdDracma = 0
@export var qtdMinerios = 0 
@export var Minerio = ""

#Centro
@export var heal = 0.0
@export var maxHp = 0.0
@export var nextHealDealy = 0.0

#Torre
@export var slow = 0.0
@export var shootSpeed = 0.0 

#Piscina
@export var poolHeal = 0.0
@export var poolHealDelay = 0.000000


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
	upgrades()
	
	$InfoDracma/Titulo.text = titulo
	$InfoDracma/Titulo.add_theme_color_override("font_color",colorTitulo)
	
	#Text
	get_node("InfoDracma/QtdDracma/Price").text = str(qtdDracma)
	if(qtd_ore_player==0 or qtd_ore_player == null):
		$InfoDracma/QtdMinerio.visible = false
	pass # Replace with function body.
	
func upgrades():
	if(whatUpgrades=="Center"):
		#Upgrades
		$InfoDracma/Upgrade1.text = "Heal: "+ str(heal)
		$InfoDracma/Upgrade2.text = "Max HP: "+ str(maxHp)
		$InfoDracma/Upgrade3.text = "Heal speed:" + str(nextHealDealy)
		pass
	elif(whatUpgrades=="Tower"):
		#Upgrades
		$InfoDracma/Upgrade1.text = "slow speed: "+ str(slow)
		$InfoDracma/Upgrade2.text = "shoot speed: "+ str(shootSpeed) 
		pass
	elif(whatUpgrades=="Pool"):
		#Upgrades
		$InfoDracma/Upgrade1.text = "Ammount Heal: "+ str(poolHeal)
		$InfoDracma/Upgrade2.text = "Heal speed: "+ str(poolHealDelay)
		pass

 
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


func _on_imagem_mouse_entered():
	if($Imagem.disabled==false):
		$InfoDracma.visible = true
	else:
		$InfoDracma.visible = false 
	pass # Replace with function body.


func _on_imagem_mouse_exited():
	get_node("InfoDracma").visible=false
	pass # Replace with function body.


func _on_imagem_pressed():
	if(whatUpgrades=="Center"):   
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player): 
			get_parent().get_parent().current_level_centro += 1
			Global.Center.heal = heal
			Global.Center.maxHp = maxHp
			Global.Center.nextHealDealy = nextHealDealy
			decreaseOre()
			get_node("Aquired").visible=true
	elif(whatUpgrades=="Tower"):  
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_sentinela+=1 
			#
			decreaseOre()
			get_node("Aquired").visible=true
	elif(whatUpgrades == "Pool"):
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_piscina+=1 
			Global.Pool.heal = poolHeal
			Global.Pool.nextHealDealy = poolHealDelay
			decreaseOre()
			get_node("Aquired").visible=true
	pass # Replace with function body.
	pass # Replace with function body.
