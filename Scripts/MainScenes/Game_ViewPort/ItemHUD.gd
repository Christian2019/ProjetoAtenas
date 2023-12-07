extends Node2D

var select=false
var speed=5
var line=0	
var maxColumn=3
var xSpace=263
var ySpace=200

func _ready():
	if (get_parent().name=="ItensHud"):
		Global.ItemHud=self
	else:
		Global.ItemHudTempleShop=self
		
	process_mode = Node.PROCESS_MODE_ALWAYS
	var columPosition=0


	
func _process(delta):
	if (select):
		if(Input.is_action_pressed("Move_Down") or Input.is_action_just_pressed("MouseWheelDown") and line>4):
				if Input.is_action_just_pressed("MouseWheelDown"):
					$SubViewportContainer/SubViewport/Itens.position.y-=speed*2
				else:
					$SubViewportContainer/SubViewport/Itens.position.y-=speed
					
		elif(Input.is_action_pressed("Move_Up") or Input.is_action_just_pressed("MouseWheelUp")):
				if Input.is_action_just_pressed("MouseWheelUp"):
					$SubViewportContainer/SubViewport/Itens.position.y+=speed*2
				else:
					$SubViewportContainer/SubViewport/Itens.position.y+=speed
				
		if ($SubViewportContainer/SubViewport/Itens.position.y>8):
			$SubViewportContainer/SubViewport/Itens.position.y=8
		if ($SubViewportContainer/SubViewport/Itens.position.y<(3-line)*ySpace) and line>4:
			$SubViewportContainer/SubViewport/Itens.position.y=(3-line)*ySpace
		

func update(item):
	$SubViewportContainer/SubViewport/Itens.add_child(item)
	var columPosition=0
	line=0

	for i in range(0,$SubViewportContainer/SubViewport/Itens.get_child_count(),1):
		var c= $SubViewportContainer/SubViewport/Itens.get_child(i)
		c.position=Vector2(columPosition*xSpace,line*ySpace)
		columPosition+=1
		if (columPosition==maxColumn):
			columPosition=0
			line+=1



func _on_area_2d_mouse_entered():
	select=true


func _on_area_2d_mouse_exited():
	select=false
