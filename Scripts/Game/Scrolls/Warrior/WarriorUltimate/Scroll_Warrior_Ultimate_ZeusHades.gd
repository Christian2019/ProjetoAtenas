extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=5
#0-hades 1-poseidon 2-zeus
var godType=2
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=4

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var cd
#Zeus
var warrior_ultimate_divine_zeus_damage
var warrior_ultimate_divine_zeus_cdReduction

#Hades
var warrior_ultimate_divine_hades_currentHPPercentDamage
var warrior_ultimate_divine_hades_skeletonQuantity
var warrior_ultimate_divine_hades_cerberusDamage



func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	cd=int((AllSkillsValues.warrior_ultimate_hades_cd+AllSkillsValues.warrior_ultimate_zeus_cd)/2)
	passive=AllSkillsValues.warrior_ultimate_divine_zeus_passive
	passive2=AllSkillsValues.warrior_ultimate_divine_hades_passive
	
	#Hades
	warrior_ultimate_divine_hades_currentHPPercentDamage=AllSkillsValues.warrior_ultimate_divine_hades_currentHPPercentDamage
	warrior_ultimate_divine_hades_skeletonQuantity=AllSkillsValues.warrior_ultimate_divine_hades_skeletonQuantity
	warrior_ultimate_divine_hades_cerberusDamage=AllSkillsValues.warrior_ultimate_divine_hades_cerberusDamage

	#Zeus
	warrior_ultimate_divine_zeus_damage=AllSkillsValues.warrior_ultimate_divine_zeus_damage
	warrior_ultimate_divine_zeus_cdReduction=AllSkillsValues.warrior_ultimate_divine_zeus_cdReduction

func addPassiveFunction():
	#Poseidon
	#Global.player.percentDamage+=passive2
	
	#Hades
	Global.player.baseMaxHp+=passive2
	
	#Zeus
	Global.player.baseDamage+=passive

func removePassiveFunction():
	#Poseidon
	#Global.player.percentDamage-=passive2
	
	#Hades
	Global.player.baseMaxHp-=passive2
	
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
	scroll.get_node("Big/AnimatedSprite2D2").frame=0
	scroll.get_node("Big/Labels/God/value3").text="hades"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[0])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="zeus"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[2])
	scroll.get_node("Big/Labels/SkillType/value").text="ultimate"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown: "
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd)+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive2)+" max hp "+ "+ "+str(passive)+" damage" 
	scroll.get_node("Big/Labels/Active/value").text="hades will make an army of "+ str(warrior_ultimate_divine_hades_skeletonQuantity)+" skeletons for 15s causing "+str(warrior_ultimate_divine_hades_currentHPPercentDamage*100)+"% current hp and heal you 1 hp per attack."+" zeus will make a rain of lightning bolts for 15 seconds causing "+str(warrior_ultimate_divine_zeus_damage)+" sd to enemies every 0.2s that explode."
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="create a cerberus* for the rest of the wave."+" reduce the cooldown by every electrified* enemy for "+ str(warrior_ultimate_divine_zeus_cdReduction) +"s. limit 0.1s cooldown."
	#scroll.get_node("Big/Labels/ExtraInfo").visible=false
	scroll.get_node("Big/Labels/ExtraInfo/value").text="cerberus*: creature that deals " + str(warrior_ultimate_divine_hades_cerberusDamage) +" sd plus the amount of hp gain by your skeletons."
