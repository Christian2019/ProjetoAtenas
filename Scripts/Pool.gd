extends Node2D

var heal=1
var nextHealDelayPlayer=false
var nextHealDealy=1

var playerInArea=false

func _process(delta):
	if playerInArea and !nextHealDelayPlayer:
		nextHealDelayPlayer=true
		Global.timerCreator("disableNextHealDelay",nextHealDealy,[],self)
		Global.player.hp+=heal
		Global.player.activateFeedback()
		if (Global.player.hp>Global.player.maxHp):
			Global.player.hp=Global.player.maxHp
		
	

func disableNextHealDelay():
	nextHealDelayPlayer=false

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		playerInArea=true

func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerInArea=false
