extends Node2D

func _ready():
	Global.ScrollController.scrollHuds.append({"scrollHud":self})
	for i in range(0,$Scrolls.get_child_count(),1):
		var s =$Scrolls.get_child(i)
		s.get_node("Big").visible=false
		s.get_node("Small").visible=true

func showSelected(index):
	if ($Scrolls.get_child(index).visible):
		if Global.ScrollController.displayBig($Selected/Scroll,index,$Selected/Buttons/Sell,$Selected/Buttons/Equip):
			$Selected.visible=true	

func _on_button_0_pressed():
	showSelected(0)

func _on_button_1_pressed():
	showSelected(1)

func _on_button_2_pressed():
	showSelected(2)

func _on_button_3_pressed():
	showSelected(3)

func _on_button_4_pressed():
	showSelected(4)

func _on_button_5_pressed():
	showSelected(5)

func _on_button_6_pressed():
	showSelected(6)

func _on_button_7_pressed():
	showSelected(7)

func _on_button_8_pressed():
	showSelected(8)

func _on_button_9_pressed():
	showSelected(9)

func _on_button_10_pressed():
	showSelected(10)

func _on_button_11_pressed():
	showSelected(11)

func _on_button_12_pressed():
	showSelected(12)

func _on_button_13_pressed():
	showSelected(13)

func _on_button_14_pressed():
	showSelected(14)


func _on_close_pressed():
	$Selected.visible=false
	Global.ScrollController.scrollSelected=null


func _on_sell_pressed():
	Global.ScrollController.sell()


func _on_equip_focus_entered():
	Global.ScrollController.changeScrollPostion()
