extends Node2D

var wood_proportion= 0.1
var gold_proportion= 0.1
var stone_proportion= 0.1
var resources = []

var max_linhas = 43
var max_colunas = 40

var start = false

func _process(delta):
	if (!start):
		createResources()
		start = true
		var rng = RandomNumberGenerator.new()
		for linha in range(0,max_linhas,1):
			for coluna in range(0,max_colunas,1):
				var quadrant_instance = PreLoads.quadrant.instantiate()
				quadrant_instance.name = str("linha", linha , "_coluna", coluna)
				quadrant_instance.position= Vector2(64*coluna,64*linha)
				if (linha>(max_linhas/2)+1):
					var index = rng.randi_range(0, resources.size()-1)
					if (resources[index]!="empty"):
						quadrant_instance.get_node("Resource").visible=true
						quadrant_instance.get_node("Resource").animation=resources[index]
					resources.remove_at(index)
				add_child(quadrant_instance)

func createResources():
	
	var total_quantity=int (max_linhas*max_colunas/2)
	var wood_quantity = int(total_quantity*wood_proportion)
	var gold_quantity = int(total_quantity*gold_proportion)
	var stone_quantity = int(total_quantity*stone_proportion)
	var empty_quantity = total_quantity-wood_quantity-gold_quantity-stone_quantity

	for i in range(0,wood_quantity,1):
		resources.append("wood")
	for i in range(0,gold_quantity,1):
		resources.append("gold")
	for i in range(0,stone_quantity,1):
		resources.append("stone")
	for i in range(0,empty_quantity,1):
		resources.append("empty")

