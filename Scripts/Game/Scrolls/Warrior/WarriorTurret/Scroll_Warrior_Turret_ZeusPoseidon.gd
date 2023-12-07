extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=4
#0-hades 1-poseidon 2-zeus
var godType=2
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=2

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var quantity
#Zeus
var warrior_turret_divine_zeus_damage
var warrior_turret_divine_zeus_extraBounces

#Poseidon
var warrior_turret_divine_poseidon_sd
var warrior_turret_divine_poseidon_pierce
var warrior_turret_divine_poseidon_waterDamage


func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	quantity=AllSkillsValues.turretsQuantity
	
	passive=AllSkillsValues.warrior_turret_divine_zeus_passive
	passive2=AllSkillsValues.warrior_turret_divine_poseidon_passive
	
	#Zeus
	warrior_turret_divine_zeus_damage=AllSkillsValues.warrior_turret_divine_zeus_damage
	warrior_turret_divine_zeus_extraBounces=AllSkillsValues.warrior_turret_divine_zeus_extraBounces
		
	#Poseidon
	warrior_turret_divine_poseidon_sd=AllSkillsValues.warrior_turret_divine_poseidon_sd
	warrior_turret_divine_poseidon_pierce=AllSkillsValues.warrior_turret_divine_poseidon_pierce
	warrior_turret_divine_poseidon_waterDamage=AllSkillsValues.warrior_turret_divine_poseidon_waterDamage

func addPassiveFunction():
	#Poseidon
	Global.player.percentDamage+=passive2
	
	#Hades
	#Global.player.baseMaxHp+=passive2
	
	#Zeus
	Global.player.baseDamage+=passive
func removePassiveFunction():
	#Poseidon
	Global.player.percentDamage-=passive2
	
	#Hades
	#Global.player.baseMaxHp-=passive2
	
	#Zeus
	Global.player.baseDamage-=passive

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}
	Global.PlayrHudController.changePlayerSkillFunction()

#MEXER
func updateScroll(scroll):
	scroll.get_node("Small/AnimatedSprite2D2").frame=skilltype
	var divine=true
	
	#NAO MEXER
	if (divine):
		quality=4
		scroll.get_node("Big/Labels/LegendaryDivineBonus/var").text="divine bonus:"
	else:
		scroll.get_node("Big/Labels/LegendaryDivineBonus/var").text="legendary bonus:"
	scroll.get_node("Scroll").frame=quality
	scroll.get_node("Small/AnimatedSprite2D").frame=skillGod
	scroll.get_node("Big/AnimatedSprite2D").frame=godType
	scroll.get_node("Big/AnimatedSprite2D2").visible=divine
	scroll.get_node("Divine").visible=divine
	scroll.get_node("Big/Labels/God/value2").visible=divine
	scroll.get_node("Big/Labels/God/value3").visible=divine
	
	#Somente se for divine segundo deus
	#0-hades 1-poseidon 2-zeus
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="zeus"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[2])
	scroll.get_node("Big/Labels/SkillType/value").text="turret"
	scroll.get_node("Big/Labels/Cooldown/var").text="quantity: "
	scroll.get_node("Big/Labels/Cooldown/value").text=str(quantity[quality])
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive)+" damage " +"+ "+str(passive2*100)+"% damage" 
	scroll.get_node("Big/Labels/Active/value").text="turret’s attack causes a lightning bolt that deal "+ str(warrior_turret_divine_poseidon_sd+warrior_turret_divine_zeus_damage) +" sd to strike nearby foes."+" turrets’s create an arrow that causes "+str(warrior_turret_divine_zeus_damage+warrior_turret_divine_poseidon_sd)+" sd. it also pierce for "+str(warrior_turret_divine_poseidon_pierce)
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="turret’s attack became chain-lightning produce "+ str(warrior_turret_divine_zeus_extraBounces) +" extra bounce. " +" arrow causes water damage*"+str(warrior_turret_divine_poseidon_waterDamage)
	#scroll.get_node("Big/Labels/ExtraInfo").visible=false
	scroll.get_node("Big/Labels/ExtraInfo/value").text="waterDamage*: extra x sd against same enemy after consecutives attacks."
