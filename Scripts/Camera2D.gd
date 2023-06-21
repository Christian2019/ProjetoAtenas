extends Camera2D


func _ready():
	print(get_viewport().size)



func _process(delta):
	moveCamera()
	
func moveCamera():
	var playerPosition = get_parent().get_node("Player").position
	var positionX= clamp(playerPosition.x,get_viewport().size.x/2,2555-get_viewport().size.x/2)
	var positionY= clamp(playerPosition.y,get_viewport().size.y/2,2757-get_viewport().size.y/2)
	position= Vector2(positionX,positionY)
