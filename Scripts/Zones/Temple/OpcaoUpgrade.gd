extends Node2D

@export var areaUpgrades = 0
@export var whatUpgrades=""
@export var valor = 0.0
@export var textura = Texture.new()
@export var textura_disable = Texture.new()

#Quantos pra comprar
@export var usaOres = false
@export var qualOre = ""
@export var qtdOres = 0
@export var qtdDracma = 0


# Called when the node enters the scene tree for the first time.
func _ready(): 
	$Imagem.texture_normal = textura
	$Imagem.texture_disabled = textura_disable
	if(usaOres):
		if(qtdDracma > 0):
			$BG_HOVER/Quantidade.text = str(qtdDracma)+" dracma \n&\n"+str(qtdOres)+" "+qualOre
		else:
			$BG_HOVER/Quantidade.text = str(qtdOres)+" "+qualOre
	else:
		$BG_HOVER/Quantidade.text = str(qtdDracma)+" dracma"
	pass # Replace with function body.
 
func _on_texture_button_pressed():
#UPGRADE PLAYER
	if(areaUpgrades==0):
		upgradePersonagem()
#UPGRADE DEFENDER POINT
	if(areaUpgrades==1): 
		upgradeCentro()
#UPGRADE MINERACAO
	if(areaUpgrades==2):
		upgradeMineracao()
	pass # Replace with function body.

func upgradeCentro():
	if(whatUpgrades=="centro"): 
		if(usaOres and qualOre=="wood"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_centro == 0):
				get_parent().get_parent().current_level_centro += 1
				Global.player.wood -= qtdOres
				Global.Center.heal = valor 
				Global.Center.maxHp = valor * 10000
				Global.Center.nextHealDealy = 0.01
		if(usaOres and qualOre=="stone"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_centro == 1):
				get_parent().get_parent().current_level_centro += 1
				Global.player.stone -= qtdOres
				Global.Center.heal = valor 
				Global.Center.maxHp = valor * 10000
				Global.Center.nextHealDealy = 0.001
		elif(usaOres and qualOre=="gold"):
			match(get_parent().get_parent().current_level_centro):
				2:
					if(Global.player.gold >= qtdOres and Global.player.dracma>=qtdDracma):
						get_parent().get_parent().current_level_centro+=1 
						Global.player.gold-=qtdOres
						Global.Center.heal = valor 
						Global.Center.maxHp = valor * 10000
						Global.Center.nextHealDealy = 0.0001
						pass
				3:
					if(Global.player.gold>=qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_centro+=1 
						Global.player.gold-=qtdOres
						Global.Center.heal = valor 
						Global.Center.maxHp = valor * 10000
						Global.Center.nextHealDealy = 0.00001
						pass
				4: 
					if(Global.player.gold>=qtdOres): 
						get_parent().get_parent().current_level_centro+=1 
						Global.player.gold-=qtdOres
						Global.Center.heal = valor 
						Global.Center.maxHp = valor * 10000
						Global.Center.nextHealDealy = 0.000001
						pass  
						
		pass
	elif(whatUpgrades=="sentinela"): 
		if(usaOres and qualOre=="wood"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_sentinelas == 0):
				get_parent().get_parent().current_level_sentinelas += 1
				Global.player.wood -= qtdOres
				
		if(usaOres and qualOre=="stone"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_sentinelas == 1):
				get_parent().get_parent().current_level_sentinelas += 1
				Global.player.stone -= qtdOres
		elif(usaOres and qualOre=="gold"):
			match(get_parent().get_parent().current_level_sentinelas):
				2:
					if(Global.player.gold >= qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_sentinelas+=1 
						Global.player.gold-=qtdOres
						pass
				3:
					if(Global.player.gold>=qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_sentinelas+=1 
						Global.player.gold-=qtdOres
						pass
				4: 
					if(Global.player.gold>=qtdOres):
						get_parent().get_parent().current_level_sentinelas+=1 
						Global.player.gold-=qtdOres
						pass  
	elif(whatUpgrades=="piscina"): 
		if(usaOres and qualOre=="wood"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_piscina == 0):
				get_parent().get_parent().current_level_piscina += 1
				Global.player.wood -= qtdOres
				Global.Pool.heal = valor
				Global.Pool.nextHealDealy = 0.01
				#Mudar animação
				Global.Pool.get_node("AnimatedSprite2D").animation = "default"
		if(usaOres and qualOre=="stone"):
			if(Global.player.wood>=qtdOres and get_parent().get_parent().current_level_piscina == 1):
				get_parent().get_parent().current_level_piscina += 1
				Global.player.stone -= qtdOres
				Global.Pool.heal = valor
				Global.Pool.nextHealDealy = 0.001
				#Mudar animação
				Global.Pool.get_node("AnimatedSprite2D").animation = "default"
		elif(usaOres and qualOre=="gold"):
			match(get_parent().get_parent().current_level_piscina):
				2:
					if(Global.player.gold >= qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_piscina+=1 
						Global.player.gold-=qtdOres
						Global.Pool.heal = valor
						Global.Pool.nextHealDealy = 0.0001
						#Mudar animação
						Global.Pool.get_node("AnimatedSprite2D").animation = "default"
						pass
				3:
					if(Global.player.gold>=qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_piscina+=1 
						Global.player.gold-=qtdOres
						Global.Pool.heal = valor
						Global.Pool.nextHealDealy = 0.00001
						#Mudar animação
						Global.Pool.get_node("AnimatedSprite2D").animation = "default"
						pass
				4: 
					if(Global.player.gold>=qtdOres):
						get_parent().get_parent().current_level_piscina+=1 
						Global.player.gold-=qtdOres
						Global.Pool.heal = valor
						Global.Center.nextHealDealy = 0.000001
						#Mudar animação
						Global.Pool.get_node("AnimatedSprite2D").animation = "default"
						pass 

func upgradeMineracao(): 
	if(whatUpgrades=="Power"):  
		print()
		if(qtdDracma <= Global.player.dracma): 
			get_parent().get_parent().current_level_Power+=1 
			Global.PlayerMining.damage_mining = valor 
			Global.player.dracma -= qtdDracma
	elif(whatUpgrades=="Bag"):  
		if(qtdDracma <= Global.player.dracma):
			get_parent().get_parent().current_level_Bag+=1 
			Global.player.MaxCarriage = valor   
			Global.player.dracma -= qtdDracma


func upgradePersonagem():
	var current_level_attack = get_parent().get_parent().current_level_attack
	#Verificar a ore que eu vou usar, e, se for a que eu quero, vejo a quantidade e adiciono o nivel
	if(whatUpgrades=="Attack"):  
		if(usaOres and qualOre=="wood"):
			if(Global.player.wood >= qtdOres and current_level_attack==0):
				get_parent().get_parent().current_level_attack+=1 
				Global.player.baseDamage=valor
				Global.player.wood-=qtdOres
				Global.player.percentDamage = valor
				Global.player.baseDamage = valor
				Global.player.percentCritDamage = valor*0.1
		elif(usaOres and qualOre=="stone"):
			if(Global.player.stone >= qtdOres and Global.player.dracma>=qtdDracma and current_level_attack==1):
				get_parent().get_parent().current_level_attack+=1 
				Global.player.baseDamage=valor 
				Global.player.stone-=qtdOres
				Global.player.percentDamage = valor
				Global.player.baseDamage = valor
				Global.player.percentCritDamage = valor*0.1
		elif(usaOres and qualOre=="gold"):
			match(current_level_attack):
				2:
					if(Global.player.gold >= qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_attack+=1
						Global.player.baseDamage=valor
						Global.player.gold-=qtdOres
						Global.player.percentDamage = valor
						Global.player.baseDamage = valor
						Global.player.percentCritDamage = valor*0.1
						pass
				3:
					if(Global.player.gold>=qtdOres and Global.player.dracma>=qtdDracma ):
						get_parent().get_parent().current_level_attack+=1
						Global.player.baseDamage=valor
						Global.player.gold-=qtdOres
						Global.player.percentDamage = valor
						Global.player.baseDamage = valor
						Global.player.percentCritDamage = valor*0.1
						pass
				4: 
					if(Global.player.gold>=qtdOres):
						get_parent().get_parent().current_level_attack+=1
						Global.player.baseDamage=valor
						Global.player.gold-=qtdOres
						Global.player.percentDamage = valor
						Global.player.baseDamage = valor
						Global.player.percentCritDamage = valor*0.1
						pass
	if(whatUpgrades=="Defense"):  
		var current_level_defense = get_parent().get_parent().current_level_defense
		if(usaOres and qualOre=="wood"):
			if(Global.player.wood >= qtdOres and current_level_defense==0):
				get_parent().get_parent().current_level_defense+=1 
				Global.player.armor=valor 
				Global.player.wood-=qtdOres
				Global.player.dodge = valor
				Global.player.armor = valor
				Global.player.maxDodge += (valor * 10)
		elif(usaOres and qualOre=="stone"):
			if(Global.player.stone >= qtdOres and current_level_defense==1):
				get_parent().get_parent().current_level_defense+=1 
				Global.player.armor=valor 
				Global.player.stone-=qtdOres
				Global.player.dodge = valor
				Global.player.armor = valor
				Global.player.maxDodge += (valor * 10)
		elif(usaOres and qualOre=="gold"):
			match(current_level_defense):
				2:
					if(Global.player.gold >= qtdOres):
						get_parent().get_parent().current_level_defense+=1
						Global.player.armor=valor
						Global.player.gold-=qtdOres
						Global.player.dodge = valor
						Global.player.armor = valor
						Global.player.maxDodge += (valor * 10)
						pass
				3:
					if(Global.player.gold>=qtdOres):
						get_parent().get_parent().current_level_defense+=1
						Global.player.armor=valor
						Global.player.gold-=qtdOres
						Global.player.dodge = valor
						Global.player.armor = valor
						Global.player.maxDodge += (valor * 10)
						pass
				4: 
					if(Global.player.gold>=qtdOres):
						get_parent().get_parent().current_level_defense+=1
						Global.player.armor=valor
						Global.player.gold-=qtdOres
						Global.player.dodge = valor
						Global.player.armor = valor
						Global.player.maxDodge += (valor * 10)
						pass


func _on_imagem_mouse_entered():
	$BG_HOVER.visible=true
	pass # Replace with function body.


func _on_imagem_mouse_exited():
	$BG_HOVER.visible = false
	pass # Replace with function body.
