extends Node2D

##MEXER
#0-noGod 1-zeus 2-poseidon 3-hades 4-ZeusPoseidon 5-ZeusHades 6-HadesPoseidon
var skillGod=3
#0-hades 1-poseidon 2-zeus
var godType=0
#0-attack1 1-attack2 2-turret 3-dash 4-ultimate
var skilltype=2

#NAO MEXER
var quality=0
var sellPrice
var passive
var passive2
#0-purple 1-blue 2-yellow 3-green 4-white
var colors=[Color8(117,0,196),Color8(71,126,255),Color8(249,218,101),Color8(0,228,0),Color8(255,255,255)]

var quantity
var warrior_turret_hades_damage
var warrior_turret_hades_area

func start():
	sellPrice=Global.ScrollController.getCurrentScrollPrice(self)
	passive=AllSkillsValues.warrior_turret_hades_passive
	#passive2=AllSkillsValues.warrior_dash_hadesPoseidon_passive2
	
	quantity=AllSkillsValues.turretsQuantity
	warrior_turret_hades_damage=AllSkillsValues.warrior_turret_hades_damage
	warrior_turret_hades_area=AllSkillsValues.warrior_turret_hades_area

func addPassiveFunction():
	Global.player.baseMaxHp+=passive[quality]
	#Global.player.baseMaxHp+=passive2
func removePassiveFunction():
	Global.player.baseMaxHp-=passive[quality]
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
	#0-hades 1-poseidon 2-zeus
	scroll.get_node("Big/AnimatedSprite2D2").frame=1
	scroll.get_node("Big/Labels/God/value3").text="poseidon"
	scroll.get_node("Big/Labels/God/value3").set("theme_override_colors/font_color", colors[1])
	
	#Olhar sempre
	scroll.get_node("Big/Labels/God/value").text="hades"
	scroll.get_node("Big/Labels/God/value").set("theme_override_colors/font_color", colors[0])
	scroll.get_node("Big/Labels/SkillType/value").text="turret"
	scroll.get_node("Big/Labels/Cooldown/var").text="quantity: " 
	scroll.get_node("Big/Labels/Active/value").text="turret’s create a ray that pierce all enemies and move slowly. It accumulates damage that explode after 5s"+str(warrior_turret_hades_damage[quality])+" sd." 
	scroll.get_node("Big/Labels/LegendaryDivineBonus/value").text="increase explosion area by "+ str((warrior_turret_hades_area-1)*100)+"%." 
	scroll.get_node("Big/Labels/ExtraInfo").visible=false
	scroll.get_node("Big/Labels/Cooldown/value").text=str(quantity[quality])
	scroll.get_node("Big/Labels/Passive/value").text="+ "+str(passive[quality])+" max hp"