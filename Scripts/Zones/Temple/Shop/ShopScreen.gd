extends Node2D

var slot1={"Scroll":null,"Item":null,"Lock":false}
var slot2={"Scroll":null,"Item":null,"Lock":false}
var slot3={"Scroll":null,"Item":null,"Lock":false}
var slot4={"Scroll":null,"Item":null,"Lock":false}

var refreshCost=0
var selected=null

func _ready():
	chageAllScrollsImages()
	clearItensSlot($Slots/Slot1/ScrollOrItem/Item/Item)
	clearItensSlot($Slots/Slot2/ScrollOrItem/Item/Item)
	clearItensSlot($Slots/Slot3/ScrollOrItem/Item/Item)
	clearItensSlot($Slots/Slot4/ScrollOrItem/Item/Item)

	$Refresh.text="reroll "+str(refreshCost)
	Global.timerCreator("refresh",0.1,[0],self)
	

func chageAllScrollsImages():
	changeScrollsImageToSmall($Slots/Slot1/ScrollOrItem/Scroll/ScrollImage)
	changeScrollsImageToSmall($Slots/Slot2/ScrollOrItem/Scroll/ScrollImage)
	changeScrollsImageToSmall($Slots/Slot3/ScrollOrItem/Scroll/ScrollImage)
	changeScrollsImageToSmall($Slots/Slot4/ScrollOrItem/Scroll/ScrollImage)

func changeScrollsImageToSmall(scroll):
	scroll.get_node("Big").visible=false
	scroll.get_node("Small").visible=true	
	
func update():
	##SCROLLS
	if slot1.Scroll!=null:
		slot1.Scroll.updateScroll($Slots/Slot1/ScrollOrItem/Scroll/ScrollImage)
		$Slots/Slot1/ScrollOrItem/Scroll.visible=true
	else:
		$Slots/Slot1/ScrollOrItem/Scroll.visible=false
		
	if slot2.Scroll!=null:
		slot2.Scroll.updateScroll($Slots/Slot2/ScrollOrItem/Scroll/ScrollImage)
		$Slots/Slot2/ScrollOrItem/Scroll.visible=true
	else:
		$Slots/Slot2/ScrollOrItem/Scroll.visible=false
		
	if slot3.Scroll!=null:
		slot3.Scroll.updateScroll($Slots/Slot3/ScrollOrItem/Scroll/ScrollImage)
		$Slots/Slot3/ScrollOrItem/Scroll.visible=true
	else:
		$Slots/Slot3/ScrollOrItem/Scroll.visible=false
		
	if slot4.Scroll!=null:
		slot4.Scroll.updateScroll($Slots/Slot4/ScrollOrItem/Scroll/ScrollImage)
		$Slots/Slot4/ScrollOrItem/Scroll.visible=true
	else:
		$Slots/Slot4/ScrollOrItem/Scroll.visible=false
		
	##ITENS	
	if slot1.Item!=null:
		$Slots/Slot1/ScrollOrItem/Item.visible=true
		$Slots/Slot1/ScrollOrItem/Item/PriceSlot1/Wood.text=str(slot1.Item.wood*2)
		$Slots/Slot1/ScrollOrItem/Item/PriceSlot1/Gold.text=str(slot1.Item.gold*2)
		$Slots/Slot1/ScrollOrItem/Item/PriceSlot1/Stone.text=str(slot1.Item.stone*2)
	else:
		$Slots/Slot1/ScrollOrItem/Item.visible=false
		
	if slot2.Item!=null:
		$Slots/Slot2/ScrollOrItem/Item.visible=true
		$BuyItens/BuyItemSlot2/Wood.text=str(slot2.Item.wood*2)
		$BuyItens/BuyItemSlot2/Gold.text=str(slot2.Item.gold*2)
		$BuyItens/BuyItemSlot2/Stone.text=str(slot2.Item.stone*2)
	else:
		$Slots/Slot2/ScrollOrItem/Item.visible=false
	
	if slot3.Item!=null:
		$Slots/Slot3/ScrollOrItem/Item.visible=true
		$BuyItens/BuyItemSlot3/Wood.text=str(slot3.Item.wood*2)
		$BuyItens/BuyItemSlot3/Gold.text=str(slot3.Item.gold*2)
		$BuyItens/BuyItemSlot3/Stone.text=str(slot3.Item.stone*2)
	else:
		$Slots/Slot3/ScrollOrItem/Item.visible=false
		
	if slot4.Item!=null:
		$Slots/Slot4/ScrollOrItem/Item.visible=true
		$BuyItens/BuyItemSlot4/Wood.text=str(slot4.Item.wood*2)
		$BuyItens/BuyItemSlot4/Gold.text=str(slot4.Item.gold*2)
		$BuyItens/BuyItemSlot4/Stone.text=str(slot4.Item.stone*2)
	else:
		$Slots/Slot4/ScrollOrItem/Item.visible=false
	
	print(slot1)	
	if (slot1.Scroll==null and slot1.Item==null):
		$Slots/Slot1.visible=false
	else:
		$Slots/Slot1.visible=true

func _process(delta):
	pass

func clearItensSlot(slot):
	if (slot.get_child_count()>0):
		slot.get_child(0).free()


func refresh(cost):
	
	if (Global.player.dracma<cost):
		return
	else:
		Global.player.dracma-=cost
	
	var rng = RandomNumberGenerator.new()
	var r
	
	#Slot1
	if (!slot1.Lock):
		clearItensSlot($Slots/Slot1/ScrollOrItem/Item/Item)
		r = rng.randi_range(0, 1)
		if (r==0):
			slot1=addScroll()
		else:
			slot1=addItem(1)
	
	#Slot2
	if (!slot2.Lock):
		clearItensSlot($Slots/Slot2/ScrollOrItem/Item/Item)
		r = rng.randi_range(0, 1)
		if (r==0):
			slot2=addScroll()
		else:
			slot2=addItem(2)
			
	#Slot3
	if (!slot3.Lock):
		clearItensSlot($Slots/Slot3/ScrollOrItem/Item/Item)
		r = rng.randi_range(0, 1)
		if (r==0):
			slot3=addScroll()
		else:
			slot3=addItem(3)
	
	#Slot4
	if (!slot4.Lock):
		clearItensSlot($Slots/Slot4/ScrollOrItem/Item/Item)
		r = rng.randi_range(0, 1)
		if (r==0):
			slot4=addScroll()
		else:
			slot4=addItem(4)
			
	update()
	#print(slot1)
	#print(slot2)
	#print(slot3)
	#print(slot4)


func addScroll():
	var quality=getRandomQuality(0.2,0.1,0.05)-1
	var scroll = getRandomScroll()
	scroll.quality=quality
	scroll.start()
	return {"Scroll":scroll,"Item":null,"Lock":false}


func addItem(slot):
	var item
	if slot==1:
		item=$Slots/Slot1/ScrollOrItem/Item/Item
	elif slot==2:
		item=$Slots/Slot2/ScrollOrItem/Item/Item
	elif slot==3:
		item=$Slots/Slot3/ScrollOrItem/Item/Item
	elif slot==4:
		item=$Slots/Slot4/ScrollOrItem/Item/Item
	
	var i1=	getRandomItem(0.2,0.1,0.05)
	var i2=i1.duplicate()
	Global.ItemController.itenReadyFunction(i2)
	i1.get_node("ItemGrab").queue_free()
	i2.get_node("ItemGrab").queue_free()
	item.add_child(i1)
	return {"Scroll":null,"Item":i2,"Lock":false}

	
func getRandomScroll():
	return 	PreLoads.scroll_warrior_dash_hades.instantiate()

func getRandomQuality(tier2Change,tier3Change,tier4Change):
	var tier
	var v=1000
	var t4=v*tier4Change*(1+Global.player.luck)
	var t3=v*tier3Change*(1+Global.player.luck)
	var t2=v*tier2Change*(1+Global.player.luck)
		
	var rng = RandomNumberGenerator.new()
	var r=rng.randi_range(0, v-1)
	if (r<t4):
		tier=4
	else:
		v-=t4
		r=rng.randi_range(0, v-1)
		if (r<t3):
			tier=3
		else:
			v-=t3
			r=rng.randi_range(0, v-1)
			if (r<t2):
				tier=2
			else:
				tier=1
	
	return tier

func getRandomItem(tier2Change,tier3Change,tier4Change):
	var tier = getRandomQuality(tier2Change,tier3Change,tier4Change)
	
	var itens
	
	if (tier==1):
		itens=PreLoads.itens_tier1
	elif(tier==2):
		itens=PreLoads.itens_tier2
	elif(tier==3):
		itens=PreLoads.itens_tier3
	elif(tier==4):
		itens=PreLoads.itens_tier4
	
	var rng = RandomNumberGenerator.new()
		
	var item = itens[rng.randi_range(0, itens.size()-1)].instantiate()
	
	return item
	

func _on_refresh_pressed():
	refresh(refreshCost)
	refreshCost+=1
	$Refresh.text="reroll "+str(refreshCost)

func focusSlot(slot):
	#slot1={"Scroll":null,"Item":null,"Lock":false}
	if slot.Scroll!=null:
		slot.Scroll.updateScroll($Focus/ScrollSelected)
		$Focus/ScrollSelected.visible=true
	elif slot.Item!=null:
		$Focus/Item.visible=true
		while ($Focus/Item.get_child_count()>0):
			$Focus/Item.get_child(0).free()
		
		var i3=slot.Item.duplicate()
		i3.get_node("ItemGrab").queue_free()
		$Focus/Item.add_child(i3)
	
func removeFocus(slot):
	$Focus/ScrollSelected.visible=false
	$Focus/Item.visible=false
	while ($Focus/Item.get_child_count()>0):
		$Focus/Item.get_child(0).free()
		
func getResources(item):
	return {"w":item.wood*2,"g":item.gold*2,"s":item.stone*2}
	
func buy(slot):
	if slot.Scroll==null:
		buyItem(slot)
	else:
		buyScroll(slot)	
	
	update()

func buyScroll(slot):
	return

func buyItem(slot):
	var r = getResources(slot.Item)
	if (Global.player.wood>=r.w):
		if (Global.player.stone>=r.s):
			if (Global.player.gold>=r.g):
				
				Global.player.gold-=r.g
				Global.player.stone-=r.s
				Global.player.wood-=r.w
				Global.ItemController.appendItem(slot.Item)
				slot.Item=null

func _on_focus_slot_1_mouse_entered():
	focusSlot(slot1)

func _on_focus_slot_1_mouse_exited():
	removeFocus(slot1)

func _on_focus_slot_2_mouse_entered():
	focusSlot(slot2)

func _on_focus_slot_2_mouse_exited():
	removeFocus(slot2)

func _on_focus_slot_3_mouse_entered():
	focusSlot(slot3)

func _on_focus_slot_3_mouse_exited():
	removeFocus(slot3)

func _on_focus_slot_4_mouse_entered():
	focusSlot(slot4)

func _on_focus_slot_4_mouse_exited():
	removeFocus(slot4)

func _on_buy_item_slot_1_pressed():
	buy(slot1)

func _on_buy_item_slot_2_pressed():
	buyItem(slot2.Item)

func _on_buy_item_slot_3_pressed():
	buyItem(slot3.Item)

func _on_buy_item_slot_4_pressed():
	
	buyItem(slot4.Item)

