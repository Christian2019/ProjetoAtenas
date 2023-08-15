extends Node2D

var canTeleport = true

var playerIn=false

var player

func _process(delta):
	if (playerIn and canTeleport):
		canTeleportFunction()
		Global.timerCreator("canTeleportFunction",1,[],self)
			
		if (get_index() ==0):
			sendToTeleport(1)
		else:
			sendToTeleport(0)

func canTeleportFunction():
	for i in range(0,get_parent().get_child_count(),1):
		get_parent().get_child(i).canTeleport=!get_parent().get_child(i).canTeleport

func sendToTeleport(child):
	player.global_position = get_parent().get_child(child).global_position
			

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		playerIn=true
		player = area.get_parent()


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerIn=false
