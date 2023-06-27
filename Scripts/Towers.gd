extends Node2D

func _ready():
	Global.timerCreator("sortTowers",1,[],self)

func sortTowers():
	Global.timerCreator("sortTowers",1,[],self)
	
	var sorted_nodes := get_children()

	sorted_nodes.sort_custom(
		# For descending order use > 0
		func(a: Node, b: Node): return a.position.y < b.position.y
	)

	for node in get_children():
		remove_child(node)

	for node in sorted_nodes:
		add_child(node)
