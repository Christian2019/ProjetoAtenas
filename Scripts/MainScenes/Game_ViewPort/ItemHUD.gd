extends Node2D

var select=false
var speed=5
var line	
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
		if(Input.is_action_pressed("Move_Down") and line>4):
				$SubViewportContainer/SubViewport/Itens.position.y-=speed
					
		elif(Input.is_action_pressed("Move_Up")):
				$SubViewportContainer/SubViewport/Itens.position.y+=speed
				
		if ($SubViewportContainer/SubViewport/Itens.position.y>8):
			$SubViewportContainer/SubViewport/Itens.position.y=8
		if ($SubViewportContainer/SubViewport/Itens.position.y<(3-line)*ySpace) and line>4:
			$SubViewportContainer/SubViewport/Itens.position.y=(3-line)*ySpace
		

func update(item):
	if (get_parent().name=="ItensHud"):
		Global.ItemHudTempleShop.update(item.duplicate())
		
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

