extends Node
#Colectables
var collectable = preload("res://Scenes/Game/Collectable.tscn")
var dracma = preload("res://Scenes/Game/Dracma.tscn")
var item = preload("res://Scenes/Game/Item.tscn")

var quadrant = preload("res://Scenes/Game/quadrant.tscn")

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

var labelDamage= preload("res://Scenes/Game/SpawnDamage.tscn")

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
var warrior_attack1_divine_ZeusPoseion=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_ZeusPoseion.tscn")
var warrior_attack1_divine_ZeusHades=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_ZeusHades.tscn")
var warrior_attack1_divine_HadesPoseidon=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_divine_HadesPoseion.tscn")

var warrior_attack1_zeus_lightning=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Zeus/Lightining.tscn")
var warrior_attack1_poseidon_heavyDamage=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1/Warrior_attack1_Poseidon/heavyDamage.tscn")

#Attack2
var warrior_attack2_noGod=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_noGod.tscn")
var warrior_attack2_zeus=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Zeus/Warrior_attack2_Zeus.tscn")
var warrior_attack2_poseidon
var warrior_attack2_hades
var warrior_attack2_divine_ZeusPoseidon
var warrior_attack2_divine_ZeusHades
var warrior_attack2_divine_HadesPoseidon

var warrior_attack2_animations_effect=preload("res://Scenes/Game/Classes/Warrior/Effects/vfx_attack_2.tscn")
var lightingBolt=preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2/Warrior_attack2_Zeus/LightiningBolt.tscn")

#Dash
var warrior_dash_noGod=preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash.tscn")
var warrior_dash_zeus
var warrior_dash_poseidon
var warrior_dash_hades
var warrior_dash_divine_ZeusPoseidon
var warrior_dash_divine_ZeusHades
var warrior_dash_divine_HadesPoseidon
var dashShadow= preload("res://Scenes/Game/Classes/Warrior/WarriorDash/DashShadow.tscn")

#Turret
var warrior_turret_noGod=preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turret.tscn")
var warrior_turret_zeus
var warrior_turret_hades
var warrior_turret_poseidon
var warrior_turret_divine_ZeusPoseidon
var warrior_turret_divine_ZeusHades
var warrior_turret_divine_HadesPoseidon
var warrior_arrow = preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/WarriorArrow.tscn")

#Ultimate
var warrior_ultimate_noGod
var warrior_ultimate_zeus=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateZeus.tscn")
var warrior_ultimate_hades= preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/WarriorUltimateHades.tscn")
var warrior_ultimate_poseidon= preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimatePoseidon/WarriorUltimatePoseidon.tscn")
var warrior_ultimate_divine_ZeusPoseidon
var warrior_ultimate_divine_ZeusHades
var warrior_ultimate_divine_HadesPoseidon
var hades_skeleton=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/skeleton.tscn")
var hades_cerberus=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimateHades/cerberus.tscn")
var poseidon_tentacle=preload("res://Scenes/Game/Classes/Warrior/WarriorUltimates/WarriorUltimatePoseidon/WarriorUltimatePoseidonTentacle.tscn")

#Effects
var eletrified =preload("res://Scenes/Game/Math_controller/Effects/Electrified.tscn")
var twister = preload("res://Scenes/Game/Math_controller/Effects/Twister.tscn")
var disorientation= preload("res://Scenes/Game/Math_controller/Effects/Disorientation.tscn")
