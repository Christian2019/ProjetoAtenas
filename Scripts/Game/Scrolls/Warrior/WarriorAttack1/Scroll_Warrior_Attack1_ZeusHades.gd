extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=5
#0-hades 1-poseidon 2-zeus
var godType=2
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=0

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var cd

#Zeus
var warrior_attack1_divine_zeus_lightningDamage
var warrior_attack1_divine_zeus_extraBounces
var warrior_attack1_divine_zeus_extraPercentDamage

#Hades
var warrior_attack1_divine_hades_attackSpeedBonusPercent
var warrior_attack1_divine_hades_frenzyPercent

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	cd=0.5
	passive=AllSkillsValues.warrior_attack1_divine_zeus_passive
	passive2=AllSkillsValues.warrior_attack1_divine_hades_passive
	
	#Zeus
	warrior_attack1_divine_zeus_lightningDamage=AllSkillsValues.warrior_attack1_divine_zeus_lightningDamage
	warrior_attack1_divine_zeus_extraBounces=AllSkillsValues.warrior_attack1_divine_zeus_extraBounces
	warrior_attack1_divine_zeus_extraPercentDamage=AllSkillsValues.warrior_attack1_divine_zeus_extraPercentDamage
	
	#Hades
	warrior_attack1_divine_hades_attackSpeedBonusPercent=AllSkillsValues.warrior_attack1_divine_hades_attackSpeedBonusPercent
	warrior_attack1_divine_hades_frenzyPercent=AllSkillsValues.warrior_attack1_divine_hades_frenzyPercent

	
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
	scroll.get_node("Big/Labels/SkillType/value").text="attack1"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown: "
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd)+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive)+" damage "+"+ "+str(passive2)+" max hp " 
	scroll.get_node("Big/Labels/Active/value").text="your attack1 emits a chain-lightning that deals "+str(warrior_attack1_divine_zeus_lightningDamage)+" sd when you damage an enemy.  produce "+str(warrior_attack1_divine_zeus_extraBounces)+" extra bounce. "+"gain temporary "+str(warrior_attack1_divine_hades_attackSpeedBonusPercent*100) +"% attack speed for 5 seconds after hitting an enemy."
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="enemies hit by attack1 get electrified* " +str((warrior_attack1_divine_zeus_extraPercentDamage-1)*100)+"%."+" gain frenezy* "+str(warrior_attack1_divine_hades_frenzyPercent*100)+"%."
	#scroll.get_node("Big/Labels/ExtraInfo").visible=false
	scroll.get_node("Big/Labels/ExtraInfo/value").text="electrified*: receive extra x damage from all sources for 5 seconds."+" frenezy*: gain  life steal for every x of your attack speed."+" heavyDamage*: x instances of attack1 in a short time."
