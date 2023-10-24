extends Node
#Colectables
var collectable = preload("res://Scenes/Game/Collectable.tscn")
var dracma = preload("res://Scenes/Game/Dracma.tscn")
var item = preload("res://Scenes/Game/Item.tscn")

var quadrant = preload("res://Scenes/Game/quadrant.tscn")

#Center
var tower = preload("res://Scenes/Game/Constructions/Defenses/Tower.tscn")
var tower_projectile = preload("res://Scenes/Game/Constructions/Defenses/Projectile.tscn")

###Enemies

##X
var x = preload("res://Scenes/Game/Enemies/X.tscn")

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

##Elites:
#Butcher
var id013 = preload("res://Scenes/Game/Enemies/id013/Id013.tscn")
var arrowAttackId013 = preload("res://Scenes/Game/Enemies/id013/ArrowAttackId013.tscn")

#Death
var id015 =preload("res://Scenes/Game/Enemies/id015/Id015.tscn")
var energyBall= preload("res://Scenes/Game/Enemies/id015/EnergyBall.tscn")


##Classes
var warrior = [
	preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1.tscn"),
	preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack2.tscn"),
	preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/Warrior_Turret.tscn"),
	preload("res://Scenes/Game/Classes/Warrior/WarriorDash/Warrior_Dash.tscn"),
	preload("res://Scenes/Game/Classes/Warrior/WarriorUltimate.tscn")
]
var warrior_arrow = preload("res://Scenes/Game/Classes/Warrior/WarriorTurret/WarriorArrow.tscn")
var dashShadow= preload("res://Scenes/Game/Classes/Warrior/WarriorDash/DashShadow.tscn")
