extends Node2D


#->Determinado pelo player
#Pode ser N,S,W,E,NE,NW,SE,SW 
var direction = "E"
var relativePosition= Vector2(0,0)

var startDistanceFromPlayer = 50

#Dano por frame (respeitando nextHitDelay)
var damage = 10

#->Graus por frame
var speed = 10

#Duracao em segundos
var cd = 3
var max_duration = 0.5
#var nextHitDelay = 10
var nextHitDelay = 1

#Monstros que foram atingidos pelo ataque
var monstersHit = []

#Monstros em contato com o ataque
var monstersInArea = []

var collidinWithPlayer=false

var reverseOrder=false

var quality="common"

var startRotationAngle

var angle


func _ready():
	$Animation.visible=false
	

var waitFrames=0
var waitMaxFrames=1
func waitFunc():
	if (waitFrames>=waitMaxFrames):
		if (waitFrames>waitMaxFrames):
			return
		startAnimation()
		startPosition()
	waitFrames+=1	


func _process(_delta):
	waitFunc()
	if (waitFrames>waitMaxFrames):
		move()
	damageAction()

func startPosition():
	relativePosition.x=startDistanceFromPlayer
	global_position= Global.player.global_position+relativePosition

func startAnimation():
	$Animation.stop()
	$Animation.visible=true
	$Animation.frame=0

	$Animation.rotate(deg_to_rad(90))
	startRotationAngle=rad_to_deg($Animation.rotation)
	$Animation.flip_v=true
	angle= startRotationAngle



func enableReverseOrder():
	reverseOrder=true

func removeNextHitDelay(arrayPosition):
	if (itsValid(monstersHit[arrayPosition])):
		monstersHit[arrayPosition].onHitDelay=false
	
func damageAction():
	if (Global.MathController.attack1_poseidon.heavyDamageHits>Global.MathController.attack1_poseidon.heavyDamageMaxHits and !Global.MathController.attack1_poseidon.heavyDamageOn):
		Global.MathController.attack1_poseidon.heavyDamageActivation()
	
	if (monstersInArea.is_empty()):
		return
	for j in range(0,monstersInArea.size(),1):
			var i = getMonsterHitIndex(monstersInArea[j])
			if itsValid(monstersHit[i]):
				if (!monstersHit[i].onHitDelay):
					Global.MathController.damageController(damage,monstersHit[i].monster)
					monstersHit[i].onHitDelay=true
					Global.timerCreator("removeNextHitDelay",nextHitDelay,[i],self)


	

func move():
	angle+=speed
	relativePosition.y=startDistanceFromPlayer*cos(deg_to_rad(angle))
	relativePosition.x=startDistanceFromPlayer*sin(deg_to_rad(angle))
	$Animation.rotation=deg_to_rad(-angle)
	global_position= Global.player.global_position+relativePosition
	
	if (angle>=startRotationAngle+360):
		Global.player.permissions[1]=true
		call_deferred("queue_free")
		
		
func _on_area_2d_area_entered(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("addMonster",area.get_parent())
	if area.get_parent().name == "Player":
		collidinWithPlayer=true
		
func _on_area_2d_area_exited(area):
	if area.get_parent().get_parent().name == "Enemies":
		call_deferred("removeMonster",area.get_parent())
	if area.get_parent().name == "Player":
		collidinWithPlayer=false

func removeMonster(monster):
	monstersInArea.erase(monster)
			
func addMonster(monster):
	monstersInArea.append(monster)
	
	if (monstersHit.is_empty()):
		monstersHit.append({"monster":monster,"onHitDelay":false,"objectReference":weakref(monster)})
	elif !checkIfExist(monster.name):
		monstersHit.append({"monster":monster,"onHitDelay":false,"objectReference":weakref(monster)})

func checkIfExist(name):
	for i in range(0,monstersHit.size(),1):
		if itsValid(monstersHit[i]):
			var monsterName= monstersHit[i].monster.name
			if (monsterName==name):
				return true
	return false

func itsValid(element):
	if (element.objectReference.get_ref()):
		return true
	return false

func getMonsterHitIndex(monster):
	for i in range(0,monstersHit.size(),1):
		if itsValid(monstersHit[i]):
			if (monstersHit[i].monster.name==monster.name):
				return i
	
