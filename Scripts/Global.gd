extends Node

var player
var Game
var Temple
var hud

var startNode

func _process(delta):
	if Input.is_action_just_pressed("Restart"):
		get_tree().change_scene_to_file("res://Scenes/MainScenes/Game_ViewPort.tscn")

#Exemplo Global.timerCreator("destroy",max_duration,[i],self)
func timerCreator(functionName,time,parameters,node):
		var timer = Timer.new()
		timer.connect("timeout",Callable(self, "timeOut").bind(timer,node,functionName,parameters))
		timer.set_wait_time(time)
		timer.one_shot=true
		timer.autostart=true
		call_deferred("add_child",timer)
		
func timeOut(timer,node,functionName,parameters):
	remove_child(timer)
	call_deferred("doAction",node,functionName,parameters)
	
func doAction(node,functionName,parameters):
	if is_instance_valid(node) and !node.is_queued_for_deletion():
		node.callv(functionName,parameters)

#Usado para testar colisoes recebe 



func areaBoxCollision(object,objectTryPosition,area2d,blockedAreas):
	var objectCollisionShape=getBoxCollision(object,objectTryPosition,area2d)
	var center
	var extents
	for index in range(blockedAreas.size()):
		if !is_instance_valid(blockedAreas[index]):
			blockedAreas[index]=null
			continue
		center= {"x":blockedAreas[index].global_position.x,"y":blockedAreas[index].global_position.y}
		extents={"x":blockedAreas[index].shape.extents.x*blockedAreas[index].global_scale.x,"y":blockedAreas[index].shape.extents.y*blockedAreas[index].global_scale.y}
		if squareCollision(objectCollisionShape.center,objectCollisionShape.extents,center,extents):
			return true
	return false
	
func getBoxCollision(object,objectPosition,area2d):
		var center= {"x":(objectPosition.x+area2d.get_children()[0].position.x*object.scale.x),"y":(objectPosition.y+area2d.get_children()[0].position.y*object.scale.y)}
		var extents= {"x":area2d.get_children()[0].shape.extents.x*object.scale.x,"y":area2d.get_children()[0].shape.extents.y*object.scale.y}
		return {"center":center,"extents":extents}

func squareCollision(centerA,extentsA,centerB,extentsB):
	if (insideInterval((centerA.x-extentsA.x),(centerB.x-extentsB.x),(centerB.x+extentsB.x)) or 
	insideInterval((centerA.x+extentsA.x) ,(centerB.x-extentsB.x),(centerB.x+extentsB.x)) or
	insideInterval((centerB.x-extentsB.x), (centerA.x-extentsA.x),(centerA.x+extentsA.x)) or
	insideInterval((centerB.x+extentsB.x) ,(centerA.x-extentsA.x),(centerA.x+extentsA.x)) 
	):
		if (insideInterval((centerA.y-extentsA.y), (centerB.y-extentsB.y),(centerB.y+extentsB.y)) or 
		insideInterval((centerA.y+extentsA.y), (centerB.y-extentsB.y),(centerB.y+extentsB.y)) or
		insideInterval((centerB.y-extentsB.y), (centerA.y-extentsA.y),(centerA.y+extentsA.y)) or
		insideInterval((centerB.y+extentsB.y), (centerA.y-extentsA.y),(centerA.y+extentsA.y)) 
		):
			return true
	return false

func insideInterval(a,b,c):
	if a>=b and a<=c:
		return true
	else:
		return false
