extends Node2D

var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=6	
#0-hades 1-poseidon 2-zeus
var godType=0
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=3

var warrior_dash_hadesPoseidon_cd
var	warrior_dash_hadesPoseidon_hpRengen
var warrior_dash_hadesPoseidon_chance
var warrior_dash_hadesPoseidon_destructionInstinct

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_dash_divine_poseidon_passive
	passive2=AllSkillsValues.warrior_dash_divine_hades_passive
	
	warrior_dash_hadesPoseidon_cd=AllSkillsValues.warrior_dash_cd
	warrior_dash_hadesPoseidon_hpRengen=AllSkillsValues.warrior_dash_divine_hades_hpRengen
	warrior_dash_hadesPoseidon_chance=AllSkillsValues.warrior_dash_divine_poseidon_chance
	warrior_dash_hadesPoseidon_destructionInstinct=AllSkillsValues.warrior_dash_divine_poseidon_destructionInstinct
	
func addPassiveFunction():
	Global.player.percentDamage+=passive
	Global.player.baseMaxHp+=passive2
func removePassiveFunction():
	Global.player.percentDamage-=passive
	Global.player.baseMaxHp-=passive2

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}	
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}	
	Global.PlayrHudController.changePlayerSkillFunction()

func updateScroll(scroll):
	quality=4
	
	scroll.get_node("Scroll").frame=quality
	scroll.get_node("Small/AnimatedSprite2D").frame=skillGod
	scroll.get_node("Big/AnimatedSprite2D").frame=godType
	
	scroll.get_node("Big/AnimatedSprite2D2").visible=true
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Divine").visible=true
	scroll.get_node("Big/Labels/LegendaryDivineBonus/var").text="divine bonus:"
	scroll.get_node("Big/Labels/God/value2").visible=true
	scroll.get_node("Big/Labels/God/value3").visible=true
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	scroll.get_node("Big/Labels/God/value").text="hades"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[0])
	scroll.get_node("Big/Labels/SkillType/value").text="dash"
	scroll.get_node("Big/Labels/Cooldown/var").text="cd:"
	scroll.get_node("Big/Labels/Cooldown/value").text=str(warrior_dash_hadesPoseidon_cd[quality])
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive*100)+"% damage"+" + "+str(passive2)+"max hp"
	scroll.get_node("Big/Labels/Active/value").text="gain "+str(warrior_dash_hadesPoseidon_chance)+"% of get 1 damage every time you get hit for 5 seconds. "+"+ "+str(warrior_dash_hadesPoseidon_hpRengen)+" hp regen"
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="gain destruction instinct* "+str(warrior_dash_hadesPoseidon_destructionInstinct*100)+"%."+" gain immortal instinct* x3"
	scroll.get_node("Big/Labels/ExtraInfo/value").text="destruction instinct*: gain x% crit of your damage. "+"immortal instinct*: multiply your hp recovery by X when life is below 50%."
	
