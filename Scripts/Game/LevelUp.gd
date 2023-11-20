extends Node2D

var level=0
var levelExperience=0
var nextLevelExp=100
var upgrades=0

#Base values Upgrade
var hp=3.0
var hpRegeneration=2.0
var lifeStealChance=0.01
var percentDamage=0.05
var baseDamage=2.0
var attack_Speed = 0.05
var percentCritDamage=0.03
var armor=1.0
var dodge=0.03
var baseMoveSpeed=0.03
var luck=0.05

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(delta):
	levelUp()
	
func levelUp():
	if (levelExperience>nextLevelExp):
		level+=1
		levelExperience=0
		nextLevelExp*=2
		upgrades+=1
