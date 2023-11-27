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
		if(whatUpgrades=="Attack"):
			get_parent().get_parent().current_level_attack+=1 
			print("ATTACK UPDATED");
			Global.player.attack_Speed+=valor 
		elif(whatUpgrades=="Defense"):
			print("Defense UPDATED");
			get_parent().get_parent().current_level_defense+=1 
			Global.player.hp+=valor
			Global.player.maxHp+=valor
#UPGRADE DEFENDER POINT
	if(areaUpgrades==1):
		if(whatUpgrades=="Heal Delay"): 
			get_parent().get_parent().current_level_MaxHP+=1 
			print("Heal Delay UPDATED");
			pass
		elif(whatUpgrades=="Max HP"): 
			get_parent().get_parent().current_level_HealthDelay+=1 
			print("Max HP UPDATED");
			pass
#UPGRADE MINERACAO
	if(areaUpgrades==2):
		if(whatUpgrades=="Power"): 
			get_parent().get_parent().current_level_Power+=1 
			Global.player.damage_mining = valor
			print("POWER UPDATED");
			pass
		elif(whatUpgrades=="Luck"): 
			get_parent().get_parent().current_level_Luck+=1 
			print("LUCK UPDATED");
			pass
		elif(whatUpgrades=="IDK"):
			get_parent().get_parent().current_level_IDK+=1 
			print("IDK UPDATED");
			pass
	pass # Replace with function body.
