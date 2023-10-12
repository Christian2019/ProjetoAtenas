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
