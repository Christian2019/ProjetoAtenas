extends Node2D

var speed=5
var line	
var maxColumn=4
var xSpace=215
var ySpace=155

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	#get_tree().paused=true
	update()
	
func _process(delta):
	if(Input.is_action_pressed("Move_Down")):
			$SubViewportContainer/SubViewport/Itens.position.y-=speed
				
	elif(Input.is_action_pressed("Move_Up")):
			$SubViewportContainer/SubViewport/Itens.position.y+=speed
			
	if ($SubViewportContainer/SubViewport/Itens.position.y>8):
		$SubViewportContainer/SubViewport/Itens.position.y=8
	if ($SubViewportContainer/SubViewport/Itens.position.y<-(line-2)*ySpace):
		$SubViewportContainer/SubViewport/Itens.position.y=-(line-2)*ySpace
		

func update():
	var columPosition=0
	line=0
	
	
	for i in range(0,$SubViewportContainer/SubViewport/Itens.get_child_count(),1):
		var c= $SubViewportContainer/SubViewport/Itens.get_child(i)
		c.position=Vector2(columPosition*xSpace,line*ySpace)
		columPosition+=1
		if (columPosition==maxColumn):
			columPosition=0
			line+=1

