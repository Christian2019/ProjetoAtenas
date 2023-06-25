extends Area2D



func _on_area_entered(area):
	if (area.get_parent().name=="Player"):
		area.get_parent().contactQuadrants.append(self)
		


func _on_area_exited(area):
	if (area.get_parent().name=="Player"):
		area.get_parent().contactQuadrants.erase(self)
		$ColorRect.visible=false
		

