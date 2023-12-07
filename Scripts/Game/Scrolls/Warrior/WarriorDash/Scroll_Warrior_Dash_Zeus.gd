extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=1	
#0-hades 1-poseidon 2-zeus
var godType=2
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=3

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var cd
var warrior_dash_zeus_moveSpeedPercentBonus
var warrior_dash_zeus_UltraInstinct
var warrior_dash_zeus_bonusSpeedDuration

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	
	#passive2=AllSkillsValues.warrior_dash_hadesPoseidon_passive2
	passive=AllSkillsValues.warrior_dash_zeus_passive
	cd=AllSkillsValues.warrior_dash_cd
	warrior_dash_zeus_moveSpeedPercentBonus=AllSkillsValues.warrior_dash_zeus_moveSpeedPercentBonus
	warrior_dash_zeus_UltraInstinct=AllSkillsValues.warrior_dash_zeus_UltraInstinct
	warrior_dash_zeus_bonusSpeedDuration=AllSkillsValues.warrior_dash_zeus_bonusSpeedDuration

func addPassiveFunction():
	Global.player.baseDamage+=passive[quality]
	#Global.player.baseMaxHp+=passive2
func removePassiveFunction():
	Global.player.baseDamage-=passive[quality]
	#Global.player.baseMaxHp-=passive2

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}	
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}	
	Global.PlayrHudController.changePlayerSkillFunction()

#MEXER
func updateScroll(scroll):
	scroll.get_node("Small/AnimatedSprite2D2").frame=skilltype
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
	#0-hades 1-poseidon 2-zeus segundo deus do nome
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	#Olhar sempre primeiro deus
	scroll.get_node("Big/Labels/God/value").text="zeus"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[2])
	scroll.get_node("Big/Labels/SkillType/value").text="dash"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown:"
	scroll.get_node("Big/Labels/Active/value").text="increase your movement speed by "+str(warrior_dash_zeus_moveSpeedPercentBonus[quality])+"% for "+str(warrior_dash_zeus_bonusSpeedDuration)+" seconds after dashes, cannot stack."
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="gain ultra instinct* "+str(warrior_dash_zeus_UltraInstinct.armor)+"/"+str(warrior_dash_zeus_UltraInstinct.dodge*100)+"%."
	scroll.get_node("Big/Labels/ExtraInfo/value").text="ultra instinct*: increase dodge and armor by that amount. Max dodge cap at "+str(warrior_dash_zeus_UltraInstinct.maxDodge)+"%"
	
	#Nao mexer
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd[quality])+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality])+"damage"
