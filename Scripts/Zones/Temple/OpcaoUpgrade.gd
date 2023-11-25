extends Node2D

@export var areaUpgrades = 0
@export var whatUpgrades=""
@export var valor = 0
@export var textura = Texture.new()
@export var textura_disable = Texture.new()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	$Imagem.texture_normal = textura
	$Imagem.texture_disabled = textura_disable
	pass # Replace with function body.
 
func _on_texture_button_pressed():
	
#UPGRADE PLAYER
	if(areaUpgrades==0):
		if(whatUpgrades=="ataque"):
			get_parent().get_parent().current_level_attack+=1  
			Global.player.attack_Speed+=valor 
		elif(whatUpgrades=="defesa"):
			print("Defense UPDATED");
			get_parent().get_parent().current_level_defense+=1 
			Global.player.hp+=valor
			Global.player.maxHp+=valor
#UPGRADE DEFENDER POINT
	if(areaUpgrades==1):
		if(whatUpgrades=="sentinelas"): 
			get_parent().get_parent().current_level_sentinelas+=1 
			print("SENTRYS UPDATED");
			pass
		elif(whatUpgrades=="centro"): 
			get_parent().get_parent().current_level_centro+=1 
			print("CENTER UPDATED");
			pass
		elif(whatUpgrades=="piscina"): 
			get_parent().get_parent().current_level_piscina+=1 
			print("POOL UPDATED");
			pass
#UPGRADE MINERACAO
	if(areaUpgrades==2):
		if(whatUpgrades=="forca"): 
			get_parent().get_parent().current_level_Power+=1 
			print("POWER UPDATED");
			pass
		elif(whatUpgrades=="bag"): 
			get_parent().get_parent().current_level_Bag+=1 
			print("BAG UPDATED");
			pass 
	pass # Replace with function body.
