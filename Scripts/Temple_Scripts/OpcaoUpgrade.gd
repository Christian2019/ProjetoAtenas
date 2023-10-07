extends Node2D

@export var areaUpgrades = 0
@export var whatUpgrades=""
@export var valor = 0
@export var textura = Texture.new()

# Called when the node enters the scene tree for the first time.
func _ready(): 
	$Imagem.texture_normal = textura
	pass # Replace with function body.
 
func _on_texture_button_pressed():
	
#UPGRADE PLAYER
	if(areaUpgrades==0):
		if(whatUpgrades=="Attack"):
			get_parent().get_parent().current_level_attack+=1 
			Global.player.attack_Speed+=valor 
		elif(whatUpgrades=="Defense"):
			get_parent().get_parent().current_level_defense+=1 
			Global.player.move_Speed+=valor
#UPGRADE DEFENDER POINT
	if(areaUpgrades==1):
		if(whatUpgrades=="Heal Delay"):
			#AUMENTAR NIVEL DO CENTRO
			get_parent().get_parent().current_level_MaxHP+=1 
			pass
		elif(whatUpgrades=="Max HP"):
			#DAR MAIS VIDA AO CENTRO
			get_parent().get_parent().current_level_HealthDelay+=1 
			pass
#UPGRADE MINERACAO
	if(areaUpgrades==2):
		if(whatUpgrades=="Power"):
			#DAR MAIS FORCA NA PICK AXE
			pass
		elif(whatUpgrades=="Luck"):
			#DAR MAIS SORTE AO PLAYER
			pass
	pass # Replace with function body.
