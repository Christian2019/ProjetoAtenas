extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=2
#0-hades 1-poseidon 2-zeus
var godType=1
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=1

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var cd
var warrior_attack2_poseidon_maxHpPercentBonus
var warrior_attack2_poseidon_damage
var warrior_attack2_poseidon_explosionDamage

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_attack2_poseidon_passive
	#passive2=AllSkillsValues.warrior_dash_hadesPoseidon_passive2
	
	cd=AllSkillsValues.warrior_attack2_cd
	warrior_attack2_poseidon_maxHpPercentBonus=AllSkillsValues.warrior_attack2_poseidon_maxHpPercentBonus
	warrior_attack2_poseidon_damage=AllSkillsValues.warrior_attack2_poseidon_damage
	warrior_attack2_poseidon_explosionDamage=AllSkillsValues.warrior_attack2_poseidon_explosionDamage

func addPassiveFunction():
	Global.player.percentDamage+=passive[quality]
	#Global.player.baseMaxHp+=passive2
func removePassiveFunction():
	Global.player.percentDamage-=passive[quality]
	#Global.player.baseMaxHp-=passive2

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}
	Global.PlayrHudController.changePlayerSkillFunction()

#MEXER
func updateScroll(scroll):
	var divine=false
	
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
	
	#Somente se for divine
	#0-hades 1-poseidon 2-zeus
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="poseidon"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[1])
	scroll.get_node("Big/Labels/SkillType/value").text="attack 2"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown:" 
	scroll.get_node("Big/Labels/Active/value").text="gain extra "+str(warrior_attack2_poseidon_damage[quality])+" sd gain extra "+ str(warrior_attack2_poseidon_maxHpPercentBonus[quality]*100) +"% max hp"
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="enemies hit by attack 2 explode, causing "+str(warrior_attack2_poseidon_explosionDamage*100)+"% of your attack 2 damage ir an area."
	scroll.get_node("Big/Labels/ExtraInfo/var").visible=false
	scroll.get_node("Big/Labels/ExtraInfo/value").text=""
	

	#NAO MEXER
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd)+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality]*100)+"% damage"
