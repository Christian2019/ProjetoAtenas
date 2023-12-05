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
var maxDodge=70
var moveSpeed=0.03
var luck=0.05

####All
###WARRIOR

#Attack2
var warrior_attack2_cd=1
#Turrets
var turretsQuantity=[1,2,3,4,5]
#Dash
var warrior_dash_cd=[0.6,0.5,0.4,0.3,0.2]

###ATTACK1
##Divine
#Hades
var warrior_attack1_divine_hades_passive=hp*5
#Poseidon
var warrior_attack1_divine_poseidon_passive=percentDamage*5
#Zeus
var warrior_attack1_divine_zeus_passive=16

##Normal
#Hades
var warrior_attack1_hades_passive=[hp,hp*2,hp*3,hp*4]
#Poseidon
var warrior_attack1_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
#Zeus
var warrior_attack1_zeus_passive=[1,2,4,8]

###ATTACK2
##Divine
#Hades
var warrior_attack2_divine_hades_passive=hp*5
var warrior_attack2_divine_hades_damage=200
var warrior_attack2_divine_hades_hpRengen=hpRegeneration*50
#Poseidon
var warrior_attack2_divine_poseidon_passive=percentDamage*5
var warrior_attack2_divine_poseidon_maxHpPercentBonus=0.48
var warrior_attack2_divine_poseidon_damage=200
var warrior_attack2_divine_poseidon_explosionDamage=1
#Zeus
var warrior_attack2_divine_zeus_passive=16
var warrior_attack2_divine_zeus_lightningBoltDamage=400
var warrior_attack2_divine_zeus_disorientation=0.6

##Normal
#Hades
var warrior_attack2_hades_passive=[hp,hp*2,hp*3,hp*4]
var warrior_attack2_hades_damage=[10,24,45,80]
var warrior_attack2_hades_soulStealCursNaxHpGain=1.0
var	warrior_attack2_hades_hpRengen=[hpRegeneration*2,hpRegeneration*5,hpRegeneration*10,hpRegeneration*25]
#Poseidon
var warrior_attack2_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
var warrior_attack2_poseidon_maxHpPercentBonus=[0.03,0.06,0.12,0.24]
var warrior_attack2_poseidon_damage=[10,24,45,80]
var warrior_attack2_poseidon_explosionDamage=0.5
#Zeus
var warrior_attack2_zeus_passive=[1,2,4,8]
var warrior_attack2_zeus_lightningBoltDamage=[20,48,90,160]
var warrior_attack2_zeus_disorientation=0.9

###TURRET
##Divine
#Hades
var warrior_turret_divine_hades_passive=hp*5
var warrior_turret_divine_hades_damage=40
var warrior_turret_divine_hades_area=2
#Poseidon
var warrior_turret_divine_poseidon_passive=percentDamage*5
var warrior_turret_divine_poseidon_sd=20
var warrior_turret_divine_poseidon_pierce=4
var warrior_turret_divine_poseidon_waterDamage=2
#Zeus
var warrior_turret_divine_zeus_passive=16
var warrior_turret_divine_zeus_damage=90
var warrior_turret_divine_zeus_extraBounces=8

##Normal
#Hades
var warrior_turret_hades_passive=[hp,hp*2,hp*3,hp*4]
var warrior_turret_hades_damage=[10,15,20,30]
var warrior_turret_hades_area=1.5

#Poseidon
var warrior_turret_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
var warrior_turret_poseidon_sd=[2,4,8,10]
var warrior_turret_poseidon_pierce=[0,1,2,3]
var warrior_turret_poseidon_waterDamage=1
#Zeus
var warrior_turret_zeus_passive=[1,2,4,8]
var warrior_turret_zeus_damage=[20,30,45,60]
var warrior_turret_zeus_extraBounces=4


##DASH
##Divine
#Hades
var warrior_dash_divine_hades_passive=hp*5
var	warrior_dash_divine_hades_hpRengen=hpRegeneration*50
#Poseidon
var warrior_dash_divine_poseidon_passive=percentDamage*5
var warrior_dash_divine_poseidon_chance=20
var warrior_dash_divine_poseidon_destructionInstinct=1
#Zeus
var warrior_dash_divine_zeus_passive=16
var warrior_dash_divine_zeus_moveSpeedPercentBonus=0.3
var warrior_dash_divine_zeus_UltraInstinct={"armor":10,"dodge":0.30,"maxDodge":80}
var warrior_dash_divine_zeus_bonusSpeedDuration=2

##Normal
#Hades
var warrior_dash_hades_passive=[hp,hp*2,hp*3,hp*4]
var	warrior_dash_hades_hpRengen=[hpRegeneration*2,hpRegeneration*5,hpRegeneration*10,hpRegeneration*25]
#Poseidon
var warrior_dash_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
var warrior_dash_poseidon_chance=[1,2,4,10]
var warrior_dash_poseidon_destructionInstinct=0.5
#Zeus
var warrior_dash_zeus_passive=[1,2,4,8]
var warrior_dash_zeus_moveSpeedPercentBonus=[0.05,0.1,0.15,0.2]
var warrior_dash_zeus_UltraInstinct = {"armor":5,"dodge":0.15,"maxDodge":80}
var warrior_dash_zeus_bonusSpeedDuration=2
	

###ULTIMATE
##Divine
#Hades
var warrior_ultimate_divine_hades_passive=hp*5
#Poseidon
var warrior_ultimate_divine_poseidon_passive=percentDamage*5
#Zeus
var warrior_ultimate_divine_zeus_passive=16

##Normal
#Hades
var warrior_ultimate_hades_passive=[hp,hp*2,hp*3,hp*4]
#Poseidon
var warrior_ultimate_poseidon_passive=[percentDamage*1,percentDamage*2,percentDamage*3,percentDamage*4]
#Zeus
var warrior_ultimate_zeus_passive=[1,2,4,8]
