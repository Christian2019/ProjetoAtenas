extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=2
#0-hades 1-poseidon 2-zeus
var godType=1
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
#Poseidon
var warrior_ultimate_poseidon_damage
var warrior_ultimate_poseidon_tentaclesQuantity

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	
	passive=AllSkillsValues.warrior_ultimate_poseidon_passive
	cd=AllSkillsValues.warrior_ultimate_poseidon_cd

	#passive2=AllSkillsValues.warrior_turret_divine_poseidon_passive
	
	#Poseidon
	warrior_ultimate_poseidon_damage=AllSkillsValues.warrior_ultimate_poseidon_damage
	warrior_ultimate_poseidon_tentaclesQuantity=AllSkillsValues.warrior_ultimate_poseidon_tentaclesQuantity

func addPassiveFunction():
	#Poseidon
	Global.player.percentDamage+=passive[quality]
	
	#Hades
	#Global.player.baseMaxHp+=passive[quality]
	
	#Zeus
	#Global.player.baseDamage+=passive
func removePassiveFunction():
	#Poseidon
	Global.player.percentDamage-=passive[quality]
	
	#Hades
	#Global.player.baseMaxHp-=passive[quality]
	
	#Zeus
	#Global.player.baseDamage-=passive

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
	
	#Somente se for divine segundo deus
	#0-hades 1-poseidon 2-zeus
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="poseidon"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[1])
	scroll.get_node("Big/Labels/SkillType/value").text="ultimate"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown: "
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd)+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality]*100)+"% damage " 
	scroll.get_node("Big/Labels/Active/value").text="poseidon will make a tsunami causing "+str(warrior_ultimate_poseidon_damage[quality])+" sd to enemies and knockback 100."
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="create a kraken for 5 seconds with "+str(warrior_ultimate_poseidon_tentaclesQuantity)+" tentacles. each tentacle copys turret skill."
	scroll.get_node("Big/Labels/ExtraInfo").visible=false
	#scroll.get_node("Big/Labels/ExtraInfo/value").text="cerberus*: creature that deals " + str(warrior_ultimate_hades_cerberusDamage) +" sd plus the amount of hp gain by your skeletons."
