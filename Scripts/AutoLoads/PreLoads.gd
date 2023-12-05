extends Node

##Itens
#Tier1
var itens_tier1=[
	preload("res://Scenes/Game/ItemController/Itens/tier1/id001.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id002.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id003.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id004.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id005.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id006.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id007.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id008.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id009.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id010.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id011.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id012.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id013.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id014.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id015.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id016.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id017.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id018.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id019.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier1/id020.tscn")
]
#Tier2
var itens_tier2=[
	preload("res://Scenes/Game/ItemController/Itens/tier2/id001.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id002.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id003.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id004.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id005.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id006.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id007.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id008.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id009.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id010.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id011.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id012.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id013.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id014.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier2/id015.tscn")
]
#Tier3
var itens_tier3=[
	preload("res://Scenes/Game/ItemController/Itens/tier3/id001.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id002.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id003.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id004.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id005.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id006.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id007.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id008.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id009.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier3/id010.tscn")
]
#Tier4
var itens_tier4=[
	preload("res://Scenes/Game/ItemController/Itens/tier4/id001.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier4/id002.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier4/id003.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier4/id004.tscn"),
	preload("res://Scenes/Game/ItemController/Itens/tier4/id005.tscn"),	
]

#Colectables
var collectable = preload("res://Scenes/Game/Collectables/Collectable.tscn")
var dracma = preload("res://Scenes/Game/Collectables/Dracma.tscn")
var item = preload("res://Scenes/Game/ItemController/ItemGrab.tscn")

var quadrant = preload("res://Scenes/Game/Mining/quadrant.tscn")

#Center
var tower = preload("res://Scenes/Game/Constructions/Defenses/Tower.tscn")
var tower_projectile = preload("res://Scenes/Game/Constructions/Defenses/Projectile.tscn")

#Temple
var scrollxtreme = preload("res://Assets/Images/Store/ScrollExtreme.png")
var scrollxtremeHover = preload("res://Assets/Images/Store/ScrollExtremeHover.png")
var scrollGood = preload("res://Assets/Images/Store/ScrollGood.png")
var scrollGoodHover = preload("res://Assets/Images/Store/ScrollGoodHover.png")
var scrollLegendary = preload("res://Assets/Images/Store/ScrollLegendary.png")
var scrollLegendaryHover = preload("res://Assets/Images/Store/ScrollLegendaryHover.png")
var scrollNormal = preload("res://Assets/Images/Store/ScrollNormal.png")
var scrollNormalHover = preload("res://Assets/Images/Store/ScrollNormalHover.png")
var item_temple = preload("res://Assets/Images/Store/RockItem.png")
var item_hover = preload("res://Assets/Images/Store/RockItemHover.png")


###Enemies

##X
var x = preload("res://Scenes/Game/Enemies/X.tscn")

#LabelDamage

var labelDamage= preload("res://Scenes/Game/Math_controller/SpawnDamage.tscn")

##Normal

#Minotaur
var id001 = preload("res://Scenes/Game/Enemies/Id001.tscn")

#Goblin
var id002 = preload("res://Scenes/Game/Enemies/Id002.tscn")

#MinotaurBlue
var id003 = preload("res://Scenes/Game/Enemies/Id003.tscn")

#MinotaurAxe
var id004 = preload("res://Scenes/Game/Enemies/Id004.tscn")

#Cupid
var id005 = preload("res://Scenes/Game/Enemies/Id005/Id005.tscn")
var arrowCircle = preload("res://Scenes/Game/Enemies/Id005/ArrowCircle.tscn")

#Minotaur3
var id006 = preload("res://Scenes/Game/Enemies/Id006.tscn")

#Pegasus
var id007 = preload("res://Scenes/Game/Enemies/id007/Id007.tscn")
var ryuseiken = preload("res://Scenes/Game/Enemies/id007/Ryuseiken.tscn")

#Dragon
var id008 = preload("res://Scenes/Game/Enemies/id008/Id008.tscn")
var dragon = preload("res://Scenes/Game/Enemies/id008/Dragon.tscn")
var arrowAttack = preload("res://Scenes/Game/Enemies/id008/ArrowAttack.tscn")

#Minotaur4
var id009 = preload("res://Scenes/Game/Enemies/Id009.tscn")

#MinotaurGreen
var id010 = preload("res://Scenes/Game/Enemies/Id010.tscn")

#Minotaur5
var id011 = preload("res://Scenes/Game/Enemies/Id011.tscn")

#Griffin
var id012 = preload("res://Scenes/Game/Enemies/Id012.tscn")

#Golem
var id014 = preload("res://Scenes/Game/Enemies/id014/Id014.tscn")
var arrowAttackId014 = preload("res://Scenes/Game/Enemies/id014/ArrowAttackId014.tscn")

#Hydra
var id016 = preload("res://Scenes/Game/Enemies/id016/Id016.tscn")
var fireball = preload("res://Scenes/Game/Enemies/id016/FireBall.tscn")

#Cat
var id017 = preload("res://Scenes/Game/Enemies/Id017.tscn")

#Minotaur6
var id019 = preload("res://Scenes/Game/Enemies/Id019.tscn")

#Worm
var id020 = preload("res://Scenes/Game/Enemies/id020/Id020.tscn")
var poison = preload("res://Scenes/Game/Enemies/id020/Poison.tscn")

##Elites:
#Butcher
var id013 = preload("res://Scenes/Game/Enemies/id013/Id013.tscn")
var arrowAttackId013 = preload("res://Scenes/Game/Enemies/id013/ArrowAttackId013.tscn")

#Death
var id015 =preload("res://Scenes/Game/Enemies/id015/Id015.tscn")
var energyBall= preload("res://Scenes/Game/Enemies/id015/EnergyBall.tscn")

##FireBird
var id018= preload("res://Scenes/Game/Enemies/id018/Id018.tscn")
var fireEnergy= preload("res://Scenes/Game/Enemies/id018/FireEnergy.tscn")

var targetDummy=preload("res://Scenes/Game/Enemies/targetDummy.tscn")

##Classes
##Warrior

#Attack1
var warrior_attack1_noGod=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_noGod.tscn")
var warrior_attack1_zeus=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Zeus/Warrior_attack1_Zeus.tscn")
var warrior_attack1_poseidon =preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Poseidon/Warrior_attack1_Poseidon.tscn")
var warrior_attack1_hades=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Hades/Warrior_attack1_Hades.tscn")
var warrior_attack1_divine_ZeusPoseion=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_ZeusPoseidon.tscn")
var warrior_attack1_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_ZeusHades.tscn")
var warrior_attack1_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_HadesPoseidon.tscn")

var warrior_attack1_zeus_lightning=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Zeus/Lightining.tscn")
var warrior_attack1_poseidon_heavyDamage=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Poseidon/heavyDamage.tscn")

#Attack2
var warrior_attack2_noGod=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_noGod.tscn")
var warrior_attack2_zeus=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Zeus/Warrior_attack2_Zeus.tscn")
var warrior_attack2_poseidon=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Poseidon/Warrior_attack2_Poseidon.tscn")
var warrior_attack2_hades= preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Hades/Warrior_attack2_Hades.tscn")
var warrior_attack2_divine_ZeusPoseidon=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_divine_ZeusPoseidon.tscn")
var warrior_attack2_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_divine_ZeusHades.tscn")
var warrior_attack2_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_divine_HadesPoseidon.tscn")

var warrior_attack2_animations_effect=preload("res://Scenes/Game/Classes/Warrior/Effects/vfx_attack_2.tscn")
var lightingBolt=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Zeus/LightiningBolt.tscn")
var warrior_attack2_poseidon_explosion= preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Poseidon/Explosion.tscn")
var warrior_attack2_hades_soulStealMark=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Hades/SoulStealMark.tscn")
var warrior_attack2_hades_soul=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Hades/Soul.tscn")

#Dash
var warrior_dash_noGod=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_noGod.tscn")
var warrior_dash_zeus=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_Zeus.tscn")
var warrior_dash_poseidon= preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_Poseidon.tscn")
var warrior_dash_hades=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_Hades.tscn")
var warrior_dash_divine_ZeusPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_ZeusPoseidon.tscn")
var warrior_dash_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_ZeusHades.tscn")
var warrior_dash_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash_HadesPoseidon.tscn")

var dashShadow= preload("res://Scenes/Game/Classes/Warrior/WarriorDash/DashShadow.tscn")

#Turret
var warrior_turret_noGod
var warrior_turret_zeus=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Zeus/Warrior_Turrret_Zeus.tscn")
var warrior_turret_hades=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Hades/Warrior_Turrret_Hades.tscn")
var warrior_turret_poseidon= preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Poseidon/Warrior_Turrret_Poseidon.tscn")
var warrior_turret_divine_ZeusPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_divine_ZeusPoseidon.tscn")
var warrior_turret_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_divine_ZeusHades.tscn")
var warrior_turret_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_divine_HadesPoseidon.tscn")

var warrior_turret_zeus_arrow = preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Zeus/Warrior_Turret_Zeus_Arrow.tscn")
var warrior_turret_poseidon_arrow = preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Poseidon/Warrior_Turret_Poseidon_Arrow.tscn")
var warrior_turret_hades_explosion= preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turrret_Hades/ExplosionHades.tscn")

#Ultimate
var warrior_ultimate_noGod
var warrior_ultimate_zeus=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateZeus.tscn")
var warrior_ultimate_hades= preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/WarriorUltimateHades.tscn")
var warrior_ultimate_poseidon= preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimatePoseidon/WarriorUltimatePoseidon.tscn")
var warrior_ultimate_divine_ZeusPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimate_divine_ZeusPoseidon.tscn")
var warrior_ultimate_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimate_divine_ZeusHades.tscn")
var warrior_ultimate_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimate_divine_HadesPoseidon.tscn")
var hades_skeleton=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/skeleton.tscn")
var hades_cerberus=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/cerberus.tscn")
var poseidon_tentacle=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimatePoseidon/WarriorUltimatePoseidonTentacle.tscn")

#Effects
var eletrified =preload("res://Scenes/Game/Math_controller/Effects/Electrified.tscn")
var twister = preload("res://Scenes/Game/Math_controller/Effects/Twister.tscn")
var disorientation= preload("res://Scenes/Game/Math_controller/Effects/Disorientation.tscn")

##Scrolls
#Attack1
#Attack2
var scroll_warrior_attack2_zeusPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Divine/Scroll_Warrior_Attack2_ZeusPoseidon.tscn")
var scroll_warrior_attack2_zeusHades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Divine/Scroll_Warrior_Attack2_ZeusHades.tscn")
var scroll_warrior_attack2_hadesPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Divine/Scroll_Warrior_Attack2_HadesPoseidon.tscn")
var scroll_warrior_attack2_hades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Scroll_Warrior_Attack2_Hades.tscn")
var scroll_warrior_attack2_poseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Scroll_Warrior_Attack2_Poseidon.tscn")
var scroll_warrior_attack2_zeus=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/Warrior_Attack2/Scroll_Warrior_Attack2_Zeus.tscn")
#Turret
var scroll_warrior_turret_zeusPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Divine/Scroll_Warrior_Turret_ZeusPoseidon.tscn")
var scroll_warrior_turret_zeusHades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Divine/Scroll_Warrior_Turret_ZeusHades.tscn")
var scroll_warrior_turret_hadesPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Divine/Scroll_Warrior_Turret_HadesPoseidon.tscn")
var scroll_warrior_turret_zeus=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Scroll_Warrior_Turret_Zeus.tscn")
var scroll_warrior_turret_hades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Scroll_Warrior_Turret_Hades.tscn")
var scroll_warrior_turret_poseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorTurret/Scroll_Warrior_Turret_Poseidon.tscn")
#Dash
var scroll_warrior_dash_zeusPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Divine/Scroll_Warrior_Dash_ZeusPoseidon.tscn")
var scroll_warrior_dash_zeusHades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Divine/Scroll_Warrior_Dash_ZeusHades.tscn")
var scroll_warrior_dash_hadesPoseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Divine/Scroll_Warrior_Dash_HadesPoseidon.tscn")
var scroll_warrior_dash_hades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Scroll_Warrior_Dash_Hades.tscn")
var scroll_warrior_dash_poseidon=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Scroll_Warrior_Dash_Poseidon.tscn")
var scroll_warrior_dash_zeus=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorDash/Scroll_Warrior_Dash_Zeus.tscn")
#Ultimate
var scroll_warrior_ultimate_hades=preload("res://Scenes/Game/ScrollsController/Scrolls/Warrior/WarriorUltimates/Scroll_Warrior_Ultimate_Hades.tscn")
