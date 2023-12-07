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

#Torre
@export var bulletSpeed = 0
@export var reloadTime = 0
@export var damageBullet = 0

#Piscina
@export var poolHeal = 0.0



@export var texture_normal = Texture.new()
@export var texture_hover = Texture.new()



var qtd_ore_player
var gold
var stone
var wood

func _process(delta):
	if(Minerio == "gold"):
		qtd_ore_player = Global.player.gold
	elif(Minerio == "stone"):
		qtd_ore_player = Global.player.stone
	elif(Minerio == "wood"):
		qtd_ore_player = Global.player.wood
		
# Called when the node enters the scene tree for the first time.
func _ready():
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
	pass # Replace with function body.
	
func upgrades():
	if(whatUpgrades=="Center"):
		#Upgrades
		$InfoDracma/Upgrades/WhatUpgrades.text = "Heal:"
		if(heal > 0):  
			$InfoDracma/Upgrades/Ammount.text = "+"+str(heal)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades/Ammount.text = "-"+str(heal)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("ff0000")) 
			
		$InfoDracma/Upgrades2/WhatUpgrades.text ="Max HP: "
		if(maxHp > 0):  
			$InfoDracma/Upgrades2/Ammount.text = "+"+str(maxHp)
			$InfoDracma/Upgrades2/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades2/Ammount.text = "-"+str(maxHp)
			$InfoDracma/Upgrades2/Ammount.add_theme_color_override("font_color",Color("ff0000"))
			
				
	elif(whatUpgrades=="Tower"):
		#Upgrades 
		$InfoDracma/Upgrades/WhatUpgrades.text = "Bullet speed: "
		if(bulletSpeed > 0):  
			$InfoDracma/Upgrades/Ammount.text = "+"+str(bulletSpeed)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades/Ammount.text = "-"+str(bulletSpeed)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("ff0000"))
			
		$InfoDracma/Upgrades2/WhatUpgrades.text ="Fire speed: "
		if(reloadTime > 0):  
			$InfoDracma/Upgrades2/Ammount.text = "+"+str(reloadTime)
			$InfoDracma/Upgrades2/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades2/Ammount.text = "-"+str(reloadTime)
			$InfoDracma/Upgrades2/Ammount.add_theme_color_override("font_color",Color("ff0000"))
		
		$InfoDracma/Upgrades3/WhatUpgrades.text = "Bullet DMG: "
		if(damageBullet > 0):  
			$InfoDracma/Upgrades3/Ammount.text = "+"+str(damageBullet)
			$InfoDracma/Upgrades3/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades3/Ammount.text = "-"+str(damageBullet)
			$InfoDracma/Upgrades3/Ammount.add_theme_color_override("font_color",Color("ff0000"))
		pass
	elif(whatUpgrades=="Pool"):
		#Upgrades
		$InfoDracma/Upgrades/WhatUpgrades.text ="Points Heal: "
		if(poolHeal > 0):  
			$InfoDracma/Upgrades/Ammount.text = "+"+str(poolHeal)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("00cc00"))
		else:
			$InfoDracma/Upgrades/Ammount.text = "-"+str(poolHeal)
			$InfoDracma/Upgrades/Ammount.add_theme_color_override("font_color",Color("ff0000"))
	

 

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
	else:
		qtd_ore_player = 0
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
	elif(whatUpgrades=="Tower"):  
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_sentinela+=1   
			for tower in Global.Tower:  
				tower.reloadTime = reloadTime
				tower.speedArrowLevelUp = bulletSpeed
				tower.damageLevelUp = damageBullet
				tower.currentLevelStore = get_parent().get_parent().current_level_sentinela
				tower.get_node("AnimatedSprite2D").animation  = "Level"+str(get_parent().get_parent().current_level_sentinela)
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
	elif(whatUpgrades == "Pool"):
		if(qtdDracma <= Global.player.dracma and qtdMinerios <= qtd_ore_player):
			get_parent().get_parent().current_level_piscina+=1 
			Global.Pool.heal = poolHeal
			Global.Pool.get_node("Animacao").play("Level"+str(get_parent().get_parent().current_level_piscina))
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

func _on_imagem_focus_entered():
	if($Imagem.disabled==false):
		$InfoDracma.visible = true
	else:
		$InfoDracma.visible = false 
	pass # Replace with function body.


func _on_imagem_focus_exited():
	get_node("InfoDracma").visible=false
	pass # Replace with function body.

func _on_turn_off_warning_timeout():
	$TurnOffWarning.wait_time=0.2
	turnOffWarning()
	pass # Replace with function body.
