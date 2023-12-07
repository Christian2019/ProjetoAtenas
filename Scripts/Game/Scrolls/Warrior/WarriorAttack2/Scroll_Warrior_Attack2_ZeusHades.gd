extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=5	
#0-hades 1-poseidon 2-zeus
var godType=2
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
#Zeus
var warrior_attack2_divine_zeus_lightningBoltDamage
var warrior_attack2_divine_zeus_disorientation

#Hades
var warrior_attack2_divine_hades_damage
var	warrior_attack2_divine_hades_hpRengen
var warrior_attack2_hades_soulStealCursNaxHpGain

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_attack2_divine_zeus_passive
	passive2=AllSkillsValues.warrior_attack2_divine_hades_passive
	cd=AllSkillsValues.warrior_attack2_cd
	
	#Zeus
	warrior_attack2_divine_zeus_lightningBoltDamage=AllSkillsValues.warrior_attack2_divine_zeus_lightningBoltDamage
	warrior_attack2_divine_zeus_disorientation=AllSkillsValues.warrior_attack2_divine_zeus_disorientation
	
	#Hades
	warrior_attack2_divine_hades_damage=AllSkillsValues.warrior_attack2_divine_hades_damage
	warrior_attack2_divine_hades_hpRengen=AllSkillsValues.warrior_attack2_divine_hades_hpRengen
	warrior_attack2_hades_soulStealCursNaxHpGain=AllSkillsValues.warrior_attack2_hades_soulStealCursNaxHpGain

func addPassiveFunction():
	Global.player.baseDamage+=passive
	Global.player.baseMaxHp+=passive2
func removePassiveFunction():
	Global.player.baseDamage-=passive
	Global.player.baseMaxHp-=passive2

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
	
	#Somente se for divine
	#0-hades 1-poseidon 2-zeus
	scroll.get_node("Big/AnimatedSprite2D2").frame=0
	scroll.get_node("Big/Labels/God/value3").text="hades"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[0])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="zeus"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[2])
	scroll.get_node("Big/Labels/SkillType/value").text="attack 2"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown: " 
	scroll.get_node("Big/Labels/Active/value").text="create 2 attack 2 instances. "+"first enemies hit by attack 2 get strikes by one lighting bolt  "+str(warrior_attack2_divine_zeus_lightningBoltDamage)+"sd. second instance cause "+str(warrior_attack2_divine_hades_damage)+"sd gain extra "+ str(warrior_attack2_divine_hades_hpRengen) +"hp regen."
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="enemies hit by heavy attack get disoriantationt* "+str((1-warrior_attack2_divine_zeus_disorientation)*100)+"%."+" enemies hit by heavy attack get permanent cursed with soul steal curse* "
	scroll.get_node("Big/Labels/ExtraInfo/value").text="disoriantationt*: movement and attack speed slowed by x% ammount for 10 seconds. "+"soul steal curse*: every 20 enemies that die while cursed gives you + "+str(warrior_attack2_hades_soulStealCursNaxHpGain) +" max hp."
	

	#NAO MEXER
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd)+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive)+" damage "+"+ "+str(passive2)+" max hp "
