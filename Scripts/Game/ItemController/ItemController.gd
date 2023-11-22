extends Node2D

var itemEquipped=[]

var itemBag=[]

func _ready():
	Global.ItemController=self

func update():
	return
	
func appendItem(item):
	var i = {"item": item}
	itemEquipped.append(i)
	update()
