extends Node2D

var quality=0
var sellPrice

var godType=0
var skilltype=3

var cd
var passive
var hpRengen

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	cd=[3,2.5,2,1.5]
	passive=[Global.LevelUp.hp,Global.LevelUp.hp*2,Global.LevelUp.hp*3,Global.LevelUp.hp*4]
	hpRengen=[Global.LevelUp.hpRegeneration*2,Global.LevelUp.hpRegeneration*5,Global.LevelUp.hpRegeneration*10,Global.LevelUp.hpRegeneration*25]

func addPassiveFunction():
	Global.player.baseMaxHp+=passive[quality]
func removePassiveFunction():
	Global.player.baseMaxHp-=passive[quality]

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":3,"quality":quality}	
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}	
	Global.PlayrHudController.changePlayerSkillFunction()

func updateScroll(scroll):
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
	scroll.get_node("Small/AnimatedSprite2D").frame=1
