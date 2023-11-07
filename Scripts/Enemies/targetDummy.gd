extends Node2D

var id="targetDummy"
var maxHp=9999999
var hp = maxHp


var maxHpBarWidth
var hpBarWidth = maxHpBarWidth

func _ready():
	maxHpBarWidth=$HPBar/Red.size.x


func _process(_delta):

	if (hp<=0):
		hp=0
		die()
		return
		
	hpBarController()


func hpBarController():
	hpBarWidth=maxHpBarWidth*hp/maxHp
	$HPBar/Green.size.x=hpBarWidth

func die():
		
	#Animacao de morte
	call_deferred("queue_free")

