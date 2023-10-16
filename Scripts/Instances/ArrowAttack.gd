extends Node2D

var speed=4
var damage=10

var maxFireScaleX

var frame=0
var maxFrames=0.5*60

var loadingTime=0.3

var start=false

func _ready():
	maxFireScaleX=$Sprite2D.scale.x
	$Sprite2D.scale.x=0
	Global.timerCreator("enableStart",loadingTime,[],self)

func enableStart():
	start=true
	$Animation.animation="Damage"

func _process(delta):
	if (!start):
		return
	
	if (frame==maxFrames):
		queue_free()
		return
	rescale()
	
	frame+=1

func rescale():
	$Sprite2D.scale.x=frame*maxFireScaleX/maxFrames


func _on_area_2d_area_entered(area):
	if (area.get_parent().name=="Player" or area.get_parent().name=="Center"):
		var enemy = area.get_parent()
		enemy.hp-=damage
		enemy.activateFeedback()
	

		
