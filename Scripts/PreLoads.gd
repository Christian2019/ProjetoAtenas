extends Node

var collectable = preload("res://Scenes/Game/Collectable.tscn")
var quadrant = preload("res://Scenes/Game/quadrant.tscn")
var minotaur = preload("res://Scenes/Game/Enemies/Minotaur.tscn")
var tower = preload("res://Scenes/Game/Constructions/Defenses/Tower.tscn")
var tower_projectile = preload("res://Scenes/Game/Constructions/Defenses/Projectile.tscn")

##Classes
var warrior = [
	preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1.tscn"),
	preload("res://Scenes/Game/Classes/Warrior/Warrior_Attack1.tscn")
]

#TEXTURAS 
var scrollxtreme = preload("res://Assets/Images/Store/ScrollExtreme.png")
var scrollxtremeHover = preload("res://Assets/Images/Store/ScrollExtremeHover.png")
var scrollGood = preload("res://Assets/Images/Store/ScrollGood.png")
var scrollGoodHover = preload("res://Assets/Images/Store/ScrollGoodHover.png")
var scrollLegendary = preload("res://Assets/Images/Store/ScrollLegendary.png")
var scrollLegendaryHover = preload("res://Assets/Images/Store/ScrollLegendaryHover.png")
var scrollNormal = preload("res://Assets/Images/Store/ScrollNormal.png")
var scrollNormalHover = preload("res://Assets/Images/Store/ScrollNormalHover.png")
var item = preload("res://Assets/Images/Store/RockItem.png")
var item_hover = preload("res://Assets/Images/Store/RockItemHover.png")
