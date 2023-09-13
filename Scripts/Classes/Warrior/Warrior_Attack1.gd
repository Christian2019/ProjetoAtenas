extends Node2D


var cd = 0.2

#Pode ser N,S,W,E,NE,NW,SE,SW
var direction = "E"

#Movimentacao por frame
var speed = 8
var playerSpeed=0
var finish=false

#Duracao em segundos
var max_duration = 0.2
var nextHitDelay = 1

#Dano por frame (respeitando nextHitDelay)
var damage = 1

#Monstros que foram atingidos pelo ataque
var monstersHit = []

func _ready():
	Global.timerCreator("finishFunction",max_duration,[],self)
	#Global.timerCreator("timer",1,[],self)
	
func timer():
	Global.timerCreator("timer",1,[],self)
	print (direction)
	
func finishFunction():
	finish=true
	
func removeNextHitDelay(position):
	monstersHit[position].onHitDelay=false
		

func _process(delta):
	if (finish):
		queue_free()
		return
	move()
	damageAction()
	
func damageAction():
	if (monstersHit.is_empty()):
		return
	for i in range(0,monstersHit.size(),1):
		if (!monstersHit[i].onHitDelay):
			monstersHit[i].monster.hp-=damage
			monstersHit[i].onHitDelay=true
			Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)

func move():
	var speedModifier=1
	
	#Corrigi a velocidade na diagonal
	if direction=="NE" or direction=="NW" or direction=="SE" or direction=="SW":
		speedModifier=1/(2**0.5)			
	
	#Y+
	if direction=="SE" or direction=="S" or direction=="SW":
		global_position.y+=(speed+playerSpeed)*speedModifier
	#Y-
	if direction=="NE" or direction=="N" or direction=="NW":
		global_position.y-=(speed+playerSpeed)*speedModifier
	
	#X+
	if direction=="SE" or direction=="E" or direction=="NE":
		global_position.x+=(speed+playerSpeed)*speedModifier
	
	#X-
	if direction=="SW" or direction=="W" or direction=="NW":
		global_position.x-=(speed+playerSpeed)*speedModifier

func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())
			
func addMonster(monster):
	if (monstersHit.is_empty()):
		monstersHit.append({"monster":monster,"onHitDelay":false})
	elif !checkIfExist(monster.name):
		monstersHit.append({"monster":monster,"onHitDelay":false})


func checkIfExist(name):
	for i in range(0,monstersHit.size(),1):
		var monsterName= monstersHit[i].monster.name
		if (monsterName==name):
			return true
	return false
	


