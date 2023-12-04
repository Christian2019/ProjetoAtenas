extends Node
#Base values
var hp=3.0
var hpRegeneration=2.0
var lifeStealChance=0.01
var percentDamage=0.05
var damage=1.0
var attack_Speed = 0.05
var percentCritDamage=0.03
var armor=1.0
var dodge=0.03
var moveSpeed=0.03
var luck=0.05

####All
###WARRIOR

#Turrets
var turretsQuantity=[1,2,3,4,5]
#Dash
var warrior_dash_cd=[0.6,0.5,0.4,0.3,0.2]

###ATTACK1
##Divine

#Hades
#Poseidon
#Zeus

##Normal

#Hades
#Poseidon
#Zeus

###ATTACK2
##Divine

#Hades
#Poseidon
#Zeus

##Normal

#Hades
#Poseidon
#Zeus

###TURRET
##Divine

#Hades
#Poseidon
#Zeus

##Normal
#Hades
#Poseidon
var warrior_turret_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
var warrior_turret_poseidon_sd=[2,4,8,10,20]
var warrior_turret_poseidon_pierce=[0,1,2,3,4]
var warrior_turret_poseidon_waterDamage=1
#Zeus

##DASH
##Divine

#Hades
var warrior_dash_divine_hades_passive=hp*5
var	warrior_dash_divine_hades_hpRengen=hpRegeneration*50
#Poseidon
var warrior_dash_divine_poseidon_passive=0.3
var warrior_dash_divine_poseidon_chance=20
var warrior_dash_divine_poseidon_destructionInstinct=1
#Zeus

##Normal
#Hades
var warrior_dash_hades_passive=[hp,hp*2,hp*3,hp*4]
var	warrior_dash_hades_hpRengen=[hpRegeneration*2,hpRegeneration*5,hpRegeneration*10,hpRegeneration*25]
#Poseidon
var warrior_dash_poseidon_passive=[0.05,0.1,0.15,0.20]
var warrior_dash_poseidon_chance=[1,2,4,10]
var warrior_dash_poseidon_destructionInstinct=0.5
#Zeus

###ULTIMATE
##Divine

#Hades
#Poseidon
#Zeus

##Normal

#Hades
#Poseidon
#Zeus
