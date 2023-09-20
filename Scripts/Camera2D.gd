extends Camera2D

var mapFinalXPosition = 2555

var mapFinalYPosition = 2757


func _ready():
	print(get_viewport().size)



func _process(_delta):
	moveCamera()
	
func moveCamera():
	
	var playerPosition = get_parent().get_node("Game").get_node("Player").position
	var positionX= clamp(playerPosition.x,(get_parent().size.x/zoom.x)/2,mapFinalXPosition-(get_parent().size.x/zoom.x)/2)
	var positionY= clamp(playerPosition.y,(get_parent().size.y/zoom.y)/2,mapFinalYPosition-(get_parent().size.y/zoom.y)/2)
	position= Vector2(positionX,positionY)
