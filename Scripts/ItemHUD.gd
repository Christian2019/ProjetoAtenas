extends Node2D

func _ready():
	update()

func update():
	var columPosition=0
	var maxColumn=4
	var line=0
	var xSpace=210
	var ySpace=155
	
	for i in range(0,$Itens.get_child_count(),1):
		var c= $Itens.get_child(i)
		c.position=Vector2(columPosition*210,line*155)
		columPosition+=1
		if (columPosition==maxColumn):
			columPosition=0
			line+=1
		
