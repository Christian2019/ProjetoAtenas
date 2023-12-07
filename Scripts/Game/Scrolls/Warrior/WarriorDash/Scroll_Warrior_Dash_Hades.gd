extends Node2D

var quality=0
var sellPrice
var passive

#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=3	
#0-hades 1-poseidon 2-zeus
var godType=0
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=3

var cd
var hpRengen

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	cd=AllSkillsValues.warrior_dash_cd
	passive=AllSkillsValues.warrior_dash_hades_passive
	hpRengen=AllSkillsValues.warrior_dash_hades_hpRengen

func addPassiveFunction():
	Global.player.baseMaxHp+=passive[quality]
func removePassiveFunction():
	Global.player.baseMaxHp-=passive[quality]

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}	
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}	
	Global.PlayrHudController.changePlayerSkillFunction()

func updateScroll(scroll):
	scroll.get_node("Small/AnimatedSprite2D2").frame=skilltype
	scroll.get_node("Divine").visible=false
	scroll.get_node("Scroll").frame=quality
	scroll.get_node("Big/AnimatedSprite2D").frame=godType
	scroll.get_node("Big/AnimatedSprite2D2").visible=false
	scroll.get_node("Big/Labels/God/value").text="hades"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", Color8(117,0,196))
	scroll.get_node("Big/Labels/SkillType/value").text="dash"
	scroll.get_node("Big/Labels/Cooldown/var").text="cooldown:"
	scroll.get_node("Big/Labels/Cooldown/value").text=str(cd[quality])+"s"
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality])+" max hp"
	scroll.get_node("Big/Labels/Active/value").text="+ "+str(hpRengen[quality])+" hp regen"
	scroll.get_node("Big/Labels/Active/value").set("theme_override_colors/font_color", Color8(0,228,0))
	scroll.get_node("Big/Labels/LegendaryDivineBonus/var").text="legendary bonus:"
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="gain immortal instinct* x2"
	scroll.get_node("Big/Labels/ExtraInfo/value").text="immortal instinct*: multiply your hp recovery by X when life is below 50%."
	scroll.get_node("Small/AnimatedSprite2D").frame=skillGod
