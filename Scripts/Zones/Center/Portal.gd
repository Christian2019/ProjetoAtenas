extends Node2D

var canTeleport = true

var playerIn=false

var player

var framesInTeleport=0
var maxFramesInTeleport=120
var cd=false
var cdTimer=2
var startModulateA=0.6
var minSpeedScale=0.1
var maxSpeedScale=2

func _ready():
	return
	#$AnimatedSprite2D.modulate.a=startModulateA
	#$AnimatedSprite2D.speed_scale=minSpeedScale	
func _process(_delta):
	if (playerIn and !cd):
		if (framesInTeleport==maxFramesInTeleport):	
			if (get_index()==0):
				sendToTeleport(1)
			else:
				sendToTeleport(0)
		else:
			if (framesInTeleport==0):
				$AudioStreamPlayer.play()
			framesInTeleport+=1
			#$AnimatedSprite2D.modulate.a=startModulateA+(1-startModulateA)*(float(framesInTeleport)/float(maxFramesInTeleport))
			#$AnimatedSprite2D.speed_scale=minSpeedScale+(maxSpeedScale-minSpeedScale)*(float(framesInTeleport)/float(maxFramesInTeleport))

func sendToTeleport(child):
	onCd()
	Global.timerCreator("onCd",cdTimer,[],self)
	player.farming= !player.farming
	player.global_position = get_parent().get_child(child).global_position
			

func onCd():
	for i in range(0, get_parent().get_child_count(),1):
		var portal = get_parent().get_child(i)
		portal.cd = !portal.cd

func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player"):
		playerIn=true
		player = area.get_parent()


func _on_area_2d_area_exited(area):
	if (area.get_parent().name=="Player"):
		playerIn=false
		if (framesInTeleport<120):
			$AudioStreamPlayer.stop()
		framesInTeleport=0
		#$AnimatedSprite2D.modulate.a=startModulateA
		#$AnimatedSprite2D.speed_scale=minSpeedScale		
