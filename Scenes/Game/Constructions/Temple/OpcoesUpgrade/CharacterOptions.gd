extends Control

@export var titulo = ""
@export var colorTitulo = Color()

@export var whatUpgrades = ""
@export var qtdDracma = 0
@export var qtdMinerios = 0 
@export var Minerio = ""

#Ataque
@export var percentDamage = 0.0
@export var percentCritDamage = 0.0
@export var baseDamage = 0.0

#Defense
@export var dodge = 0.0
@export var armor = 0.0
@export var maxDodge = 0.0


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
	
	#Titulo
	$InfoDracma/Titulo.add_theme_color_override("font_color",colorTitulo)
	$InfoDracma/Titulo.text = titulo
	#Text
	get_node("InfoDracma/QtdDracma/Price").text = str(qtdDracma)
	if(qtd_ore_player==0 or qtd_ore_player == null):
		$InfoDracma/QtdMinerio.visible = false
	pass # Replace with function body.
 
		
func upgrades():
	if(whatUpgrades=="Attack"):
		#Upgrades
		if(percentDamage>0):
			$InfoDracma/Upgrade1/Price.text = "+"+str(percentDamage)+"%"
			$InfoDracma/Upgrade1/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade1/Price.text = "-"+str(percentDamage)+"%"
			$InfoDracma/Upgrade1/Price.add_theme_color_override("font_color",Color("ff0000"))
		$InfoDracma/Upgrade1/Upgrade.animation="%Damage"
		#Upgrades2
		if(percentCritDamage>0):
			$InfoDracma/Upgrade2/Price.text = "+"+str(percentCritDamage*100)+"%"
			$InfoDracma/Upgrade2/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade2/Price.text = "-"+str(percentCritDamage*100)+"%"
			$InfoDracma/Upgrade2/Price.add_theme_color_override("font_color",Color("ff0000"))
		$InfoDracma/Upgrade2/Upgrade2.animation="%CritDamage"
		#Upgrades3
		if(baseDamage>0):
			$InfoDracma/Upgrade3/Price.text = "+"+str(baseDamage)
			$InfoDracma/Upgrade3/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade3/Price.text = "-"+str(baseDamage)
			$InfoDracma/Upgrade3/Price.add_theme_color_override("font_color",Color("ff0000")) 
		$InfoDracma/Upgrade3/Upgrade3.animation="BaseDamage"
	elif(whatUpgrades=="Defense"):
		#Upgrades 
		if(dodge>0):
			$InfoDracma/Upgrade1/Price.text = "+"+str(dodge)
			$InfoDracma/Upgrade1/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade1/Price.text = "-"+str(dodge)
			$InfoDracma/Upgrade1/Price.add_theme_color_override("font_color",Color("ff0000")) 
		$InfoDracma/Upgrade1/Upgrade.animation="Dodge"
		#Upgrades2 
		if(armor>0):
			$InfoDracma/Upgrade2/Price.text = "+"+str(armor)
			$InfoDracma/Upgrade2/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade2/Price.text = "-"+str(armor)
			$InfoDracma/Upgrade2/Price.add_theme_color_override("font_color",Color("ff0000"))  
		$InfoDracma/Upgrade2/Upgrade2.animation="armor"
		#Upgrades3
		if(maxDodge>0):
			$InfoDracma/Upgrade3/Price.text = "+"+str(maxDodge)
			$InfoDracma/Upgrade3/Price.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrade3/Price.text = "-"+str(maxDodge)
			$InfoDracma/Upgrade3/Price.add_theme_color_override("font_color",Color("ff0000"))  
		$InfoDracma/Upgrade3/Upgrade3.animation="MaxDodge"

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
	if(whatUpgrades=="Attack"):   
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player): 
			get_parent().get_parent().current_level_attack+=1 
			Global.player.percentDamage = percentDamage
			Global.player.baseDamage = baseDamage
			Global.player.percentCritDamage = percentCritDamage
			Global.player.dracma -= qtdDracma
			Global.player.current_level_sword = get_parent().get_parent().current_level_attack
			Global.player.change_animation()
			decreaseOre()
			get_node("Aquired").visible=true
	elif(whatUpgrades=="Defense"):  
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_defense+=1
			Global.player.dodge = dodge
			Global.player.armor = armor
			Global.player.maxDodge = maxDodge
			Global.player.dracma -= qtdDracma
			Global.player.current_level_armor = get_parent().get_parent().current_level_defense
			Global.player.change_animation()
			decreaseOre()
			get_node("Aquired").visible=true
	pass # Replace with function body.
	pass # Replace with function body.


func _on_imagem_focus_entered():
	if($Imagem.disabled==false):
		$InfoDracma.visible = true
	else:
		$InfoDracma.visible = false 
	pass # Replace with function body.


func _on_imagem_focus_exited():
	get_node("InfoDracma").visible=false
	pass # Replace with function body.
