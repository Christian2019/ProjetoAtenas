extends Area2D


func _on_area_entered(area):
	if (area.get_parent().name=="Player"):
		$ColorRect.visible=true


func _on_area_exited(area):
	if (area.get_parent().name=="Player"):
		$ColorRect.visible=false
		

