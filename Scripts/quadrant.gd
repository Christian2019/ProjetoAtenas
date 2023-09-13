extends Area2D

var constructionArea=false

var tower

var allowToConstruct=false

func _process(_delta):
	permissions()
	

func permissions():
	if (constructionArea):
		if (tower==null and !allowToConstruct):
			allowToConstruct=true
			$ColorRect.color = Color("00f813")
		elif (tower!=null and allowToConstruct):
			allowToConstruct=false
			$ColorRect.color = Color("f44336")

func _on_area_entered(area):
	if 	(area.name=="ConstructionArea"):
		constructionArea=true
		
	if (area.get_parent().name=="Player"):
		area.get_parent().contactQuadrants.append(self)
		


func _on_area_exited(area):
	if (area.get_parent().name=="Player"):
		area.get_parent().contactQuadrants.erase(self)
		$ColorRect.visible=false
		

