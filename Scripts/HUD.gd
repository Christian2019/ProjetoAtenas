extends Node2D

func _process(delta):
	updateResources()
	
func updateResources():
	if (Global.player!=null):
		$Frontground/Wood/Label.text =  str("Wood ",Global.player.wood)
		$Frontground/Gold/Label.text =  str("Gold ",Global.player.gold)
		$Frontground/Stone/Label.text =  str("Stone ",Global.player.stone)
