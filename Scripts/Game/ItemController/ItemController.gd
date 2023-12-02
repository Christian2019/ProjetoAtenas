extends Node2D

var itemEquipped=[]

var itemBag=[]

var selected=0

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.ItemController=self
	$ItemBagScreen.visible=false

	
func appendItem(item):
	var i = {"item": item}
	itemEquipped.append(i)
	item.addFunction()
	Global.ItemHud.update(item.duplicate())
	Global.ItemHudTempleShop.update(item.duplicate())

func appendItemBag(item):
	var i = {"item": item.duplicate()}
	itemBag.append(i)
	item.queue_free()

func _process(delta):
	if (Global.WaveController.mining and Global.LevelUp.upgrades==0 and itemBag.size()>0 and !$ItemBagScreen.visible):
		$ItemBagScreen.visible=true
		get_tree().paused = true
		selected=0
		changeItem()
	
	elif $ItemBagScreen.visible and itemBag.size()==0:
		$ItemBagScreen.visible=false
		get_tree().paused = false
	
	elif ($ItemBagScreen.visible):
		if (itemBag.size()==0):
			visible=false
			get_tree().paused = false
			return
		buttonSelection()
	
		
func changeItem():
	var currentItem=itemBag[0].item.duplicate()
	$ItemBagScreen/Item.add_child(currentItem)
	$ItemBagScreen/Recycle/Gold/Label.text=str(currentItem.gold)
	$ItemBagScreen/Recycle/Stone/Label.text=str(currentItem.stone)
	$ItemBagScreen/Recycle/Wood/Label.text=str(currentItem.wood)
	currentItem.position=Vector2(0,0)
	currentItem.get_node("Item").visible=true
	$ItemBagScreen/Label2.text="("+str(itemBag.size())+")"

func buttonSelection():
	if Input.is_action_just_pressed("Move_Up"):
		if (selected==1):
			selected=0
	elif Input.is_action_just_pressed("Move_Down"):
		if (selected==0):
			selected=1
	
	updateItemBagScreen()
	if (Input.is_action_just_pressed("Select")):
		select()

func select():
	if (selected==0):
		appendItem($ItemBagScreen/Item.get_child(0).duplicate())
		$ItemBagScreen/Item.get_child(0).queue_free()
		itemBag.remove_at(0)
		if (itemBag.size()>0):
			changeItem()
	else:
		Global.player.wood+=$ItemBagScreen/Item.get_child(0).wood
		Global.player.gold+=$ItemBagScreen/Item.get_child(0).gold
		Global.player.stone+=$ItemBagScreen/Item.get_child(0).stone
		Global.hud.updateResources()
		$ItemBagScreen/Item.get_child(0).queue_free()
		itemBag.remove_at(0)
		if (itemBag.size()>0):
			changeItem()	

func updateItemBagScreen():
	if (selected==0):
		$ItemBagScreen/Recycle/UnSelected.visible=true
		$ItemBagScreen/Take/UnSelected.visible=false
	else:
		$ItemBagScreen/Recycle/UnSelected.visible=false
		$ItemBagScreen/Take/UnSelected.visible=true

func getRandomValue(quality):
	var valueTotal=3
	var wood=0
	var stone=0
	var gold=0
	
	if (quality==0):
		valueTotal*=1
	elif (quality==1):
		valueTotal*=2
	elif (quality==2):
		valueTotal*=3
	elif (quality==3):
		valueTotal*=4
	
	var rng = RandomNumberGenerator.new()
	
	for i in range(0,valueTotal,1):
		var x = rng.randi_range(0, 2)
		if x==0:
			wood+=1
		elif x==1:
			stone+=1
		elif x==2:
			gold+=1
	
	return {"wood":wood,"stone":stone,"gold":gold}

func itenReadyFunction(item):
	item.get_node("Item").get_node("Quality").frame=item.quality
	item.get_node("Item").get_node("Icons").frame=item.itenGrabFrame
	item.get_node("Item").get_node("item_name").text=item.item_name
	item.get_node("Item").get_node("descriptionPositive").text=item.descriptionPositive
	item.get_node("Item").get_node("descriptionNegative").text=item.descriptionNegative
	item.get_node("ItemGrab").get_node("Itens").frame=item.itenGrabFrame
	var resources=getRandomValue(item.quality)
	item.wood=resources.wood
	item.stone=resources.stone
	item.gold=resources.gold
	
func dropIten(tier2Change,tier3Change,tier4Change,element):
	var tier
	var v=100
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
	
	var itens
	
	if (tier==1):
		itens=PreLoads.itens_tier1
	elif(tier==2):
		itens=PreLoads.itens_tier2
	elif(tier==3):
		itens=PreLoads.itens_tier3
	elif(tier==4):
		itens=PreLoads.itens_tier4
		
	var item = itens[rng.randi_range(0, itens.size()-1)].instantiate()
	item.get_node("Item").visible=false
	Global.Game.get_node("Instances/Itens").add_child(item)
	item.global_position=element.global_position
