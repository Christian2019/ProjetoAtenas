extends Node2D

var maxHp=50
var hp = maxHp

##Feedback por levar dano ou curar
var feedBackAtive=false
var reverseAlphaChange=false

var heal=0.1
var nextHealDelay=false
var nextHealDealy=0.1

func _ready():
	Global.Center=self

func _process(delta):
	if (hp<=0):
		hp=0
		Global.player.hp=0
		return
	feedback()
	autoRegen()
	
func autoRegen():
		if (!nextHealDelay):
			nextHealDelay=true
			Global.timerCreator("disableNextHealDelay",nextHealDealy,[],self)
			hp+=heal
			if (hp>maxHp):
				hp=maxHp
		
	

func disableNextHealDelay():
	nextHealDelay=false
		
func feedback():
	if (feedBackAtive):
		var feedbackSpeed=0.04
		if (!reverseAlphaChange):
			modulate.a -= feedbackSpeed
			if (modulate.a<=0.0):
				reverseAlphaChange=true
		else:
			modulate.a += feedbackSpeed
			if (modulate.a>=1):
				reverseAlphaChange=false

func activateFeedback():
	if (!feedBackAtive):
		feedBackAtive=true
		Global.timerCreator("disableFeeback",1,[],self)
		
func disableFeeback():
	feedBackAtive=false
	modulate.a=1
