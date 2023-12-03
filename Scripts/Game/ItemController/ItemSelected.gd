extends Node

func _on_button_mouse_entered():
	if Global.TempleScreen.visible:
		Global.ItemHudTempleShop.get_node("SelectedItemBigLeft").get_child(0).queue_free()
		var copy=self.duplicate()
		copy.get_node("Button").queue_free()
		Global.ItemHudTempleShop.get_node("SelectedItemBigLeft").add_child(copy)
		Global.ItemHudTempleShop.get_node("SelectedItemBigLeft").visible=true


func _on_button_mouse_exited():
	if Global.TempleScreen.visible:
		Global.ItemHudTempleShop.get_node("SelectedItemBigLeft").visible=false
