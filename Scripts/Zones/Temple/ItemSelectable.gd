extends Node2D


@export var texture = Texture.new()
@export var texture_hover = Texture.new()
@export var texture_inactive = Texture.new()
# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var get_parent = get_parent() 
	pass
	
func _on_area_select_area_entered(area):
	$Dados.visible=true
	$Icon.texture = texture_hover
	pass # Replace with function body.


func _on_area_select_area_exited(area):
	$Dados.visible=false
	$Icon.texture = texture
	pass # Replace with function body.
