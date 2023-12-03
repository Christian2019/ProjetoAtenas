extends Node2D


var attack1=[PreLoads.warrior_attack1_noGod,
	PreLoads.warrior_attack1_zeus,
	PreLoads.warrior_attack1_poseidon,
	PreLoads.warrior_attack1_hades,
	PreLoads.warrior_attack1_divine_ZeusPoseion,
	PreLoads.warrior_attack1_divine_ZeusHades,
	PreLoads.warrior_attack1_divine_HadesPoseidon]

var attack2=[PreLoads.warrior_attack2_noGod,
	PreLoads.warrior_attack2_zeus,
	PreLoads.warrior_attack2_poseidon,
	PreLoads.warrior_attack2_hades,
	PreLoads.warrior_attack2_divine_ZeusPoseidon,
	PreLoads.warrior_attack2_divine_ZeusHades,
	PreLoads.warrior_attack2_divine_HadesPoseidon]

var turret=[PreLoads.warrior_turret_noGod,
	PreLoads.warrior_turret_zeus,
	PreLoads.warrior_turret_poseidon,
	PreLoads.warrior_turret_hades,
	PreLoads.warrior_turret_divine_ZeusPoseidon,
	PreLoads.warrior_turret_divine_ZeusHades,
	PreLoads.warrior_turret_divine_HadesPoseidon]

var dash=[PreLoads.warrior_dash_noGod,
	PreLoads.warrior_dash_zeus,
	PreLoads.warrior_dash_poseidon,
	PreLoads.warrior_dash_hades,
	PreLoads.warrior_dash_divine_ZeusPoseidon,
	PreLoads.warrior_dash_divine_ZeusHades,
	PreLoads.warrior_dash_divine_HadesPoseidon]

var ultimate=[PreLoads.warrior_ultimate_noGod,
	PreLoads.warrior_ultimate_zeus,
	PreLoads.warrior_ultimate_poseidon,
	PreLoads.warrior_ultimate_hades,
	PreLoads.warrior_ultimate_divine_ZeusPoseidon,
	PreLoads.warrior_ultimate_divine_ZeusHades,
	PreLoads.warrior_ultimate_divine_HadesPoseidon]

var qualitys = ["common",
"rare",
"epic",
"legendary"
]

var skills=[{"skill":0,"quality":0},
{"skill":0,"quality":0},
{"skill":4,"quality":0},
{"skill":0,"quality":0},
{"skill":0,"quality":0}
]

func _ready():
	Global.PlayrHudController=self
	Global.timerCreator("changePlayerSkillFunction",0.1,[],self)

func changePlayerSkillFunction():
	Global.player.attack1={"skill":attack1[skills[0].skill], "quality": qualitys[skills[0].quality]}
	Global.hud.get_node("Skills/Attack1/Attack1").frame=skills[0].skill
	changeColor("Skills/Attack1/Border",skills[0].quality)
	if (skills[0].skill)>3:
		Global.hud.get_node("Skills/Attack1/Divine").visible=true
	else:
		Global.hud.get_node("Skills/Attack1/Divine").visible=false

	Global.player.attack2={"skill":attack2[skills[1].skill], "quality": qualitys[skills[1].quality]}
	Global.hud.get_node("Skills/Attack2/Attack2").frame=skills[1].skill
	changeColor("Skills/Attack2/Border",skills[1].quality)
	if (skills[1].skill)>3:
		Global.hud.get_node("Skills/Attack2/Divine").visible=true
	else:
		Global.hud.get_node("Skills/Attack2/Divine").visible=false
	
	Global.player.turret={"skill":turret[skills[2].skill], "quality": qualitys[skills[2].quality]}
	Global.hud.get_node("Skills/Turret/Turret").frame=skills[2].skill
	changeColor("Skills/Turret/Border",skills[2].quality)
	if (skills[2].skill)>3:
		Global.hud.get_node("Skills/Turret/Divine").visible=true
	else:
		Global.hud.get_node("Skills/Turret/Divine").visible=false
	
	Global.player.dash={"skill":dash[skills[3].skill], "quality": qualitys[skills[3].quality]}
	Global.hud.get_node("Skills/Dash/Dash").frame=skills[3].skill
	changeColor("Skills/Dash/Border",skills[3].quality)
	if (skills[3].skill)>3:
		Global.hud.get_node("Skills/Dash/Divine").visible=true
	else:
		Global.hud.get_node("Skills/Dash/Divine").visible=false
	
	Global.player.ultimate={"skill":ultimate[skills[4].skill], "quality": qualitys[skills[4].quality]}
	Global.hud.get_node("Skills/Ultimate/Ultimate").frame=skills[4].skill
	changeColor("Skills/Ultimate/Border",skills[4].quality)
	if (skills[4].skill)>3:
		Global.hud.get_node("Skills/Ultimate/Divine").visible=true
	else:
		Global.hud.get_node("Skills/Ultimate/Divine").visible=false

	
func changeColor(path,q):
	if (q==0):
		Global.hud.get_node(path).set("color", Color8(150, 201, 49))
	elif (q==1):
		Global.hud.get_node(path).set("color", Color8(76, 76, 204))
	elif (q==2):
		Global.hud.get_node(path).set("color", Color8(117, 0, 196))
	elif (q==3):
		Global.hud.get_node(path).set("color", Color8(255, 149, 1))
