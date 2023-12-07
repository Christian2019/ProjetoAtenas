extends Node2D

var quality=0
var sellPrice
var passive

#0-purple 1-blue 2-yellow 3-green 4-white

var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=2	
#0-hades 1-poseidon 2-zeus
var godType=1
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=2

var quantity
var sd
var pierce
var waterDamage

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_turret_poseidon_passive
	
	quantity=AllSkillsValues.turretsQuantity
	sd=AllSkillsValues.warrior_turret_poseidon_sd
	pierce=AllSkillsValues.warrior_turret_poseidon_pierce
	waterDamage=AllSkillsValues.warrior_turret_poseidon_waterDamage
	
func addPassiveFunction():
	Global.player.percentDamage+=passive[quality]
func removePassiveFunction():
	Global.player.percentDamage-=passive[quality]

func addActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":skillGod,"quality":quality}	
	Global.PlayrHudController.changePlayerSkillFunction()

func removeActiveFunction():
	Global.PlayrHudController.skills[skilltype]={"skill":0,"quality":0}	
	Global.PlayrHudController.changePlayerSkillFunction()

func updateScroll(scroll):
	scroll.get_node("Small/AnimatedSprite2D2").frame=skilltype
	scroll.get_node("Scroll").frame=quality
	scroll.get_node("Big/AnimatedSprite2D").frame=godType
	scroll.get_node("Big/AnimatedSprite2D2").visible=false
	scroll.get_node("Small/AnimatedSprite2D").frame=skillGod
	
	scroll.get_node("Divine").visible=false
	scroll.get_node("Big/Labels/LegendaryDivineBonus/var").text="legendary bonus:"
	
	scroll.get_node("Big/Labels/God/value").text="poseidon"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[0])
	scroll.get_node("Big/Labels/SkillType/value").text="turret"
	scroll.get_node("Big/Labels/Cooldown/var").text="quantity:"
	scroll.get_node("Big/Labels/Cooldown/value").text=str(quantity[quality])
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality]*100)+"% damage"
	scroll.get_node("Big/Labels/Active/value").text="turrets’s attack causes "+str(sd[quality])+"(sd). it also pierce for "+str(pierce[quality])
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="turret’s attack cause waterDamage*"+str(waterDamage)
	scroll.get_node("Big/Labels/ExtraInfo/value").text="waterDamage*: extra x sd against same enemy after consecutives attacks."
	
