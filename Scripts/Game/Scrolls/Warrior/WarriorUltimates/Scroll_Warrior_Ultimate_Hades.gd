extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=3
#0-hades 1-poseidon 2-zeus
var godType=0
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
var warrior_dash_poseidon_chance
var warrior_dash_poseidon_destructionInstinct

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_dash_poseidon_passive
	#passive2=AllSkillsValues.warrior_dash_hadesPoseidon_passive2
	
	cd=AllSkillsValues.warrior_dash_cd
	warrior_dash_poseidon_chance=AllSkillsValues.warrior_dash_poseidon_chance
	warrior_dash_poseidon_destructionInstinct=AllSkillsValues.warrior_dash_poseidon_destructionInstinct

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
	scroll.get_node("Big/Labels/God/value").text="hades"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[0])
	scroll.get_node("Big/Labels/SkillType/value").text="ultimate"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown:" 
	scroll.get_node("Big/Labels/Active/value").text="hades will create an army of x skeletons for 15 seconds causing "+str(warrior_dash_poseidon_chance[quality])+" (Current HP) and heal you 1 HP per attack"
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="create a cerberus for the rest of the wave that damages* "+str(warrior_dash_poseidon_destructionInstinct*100)+"SD plus the ammount of HP gained by your skeletons."
	scroll.get_node("Big/Labels/ExtraInfo/value").text=""
	

	#NAO MEXER
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd[quality])+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality]*100)+"% damage"
