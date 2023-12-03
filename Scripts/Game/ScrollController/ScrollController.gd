extends Node2D

var scrollSelected=null

var scrollsActives=[null,null,null,null,null]
var sAHudPosition=[0,3,6,9,12]

var scrollsPassives=[null,null,null,null,null,null,null,null,null,null]
var sPHudPosition=[1,2,4,5,7,8,10,11,13,14]

var scrollHuds=[]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.ScrollController=self
	Global.timerCreator("test",0.1,[],self)
	
func test():
	var skill =PreLoads.scroll_warrior_dash_hades.instantiate()
	skill.quality=2
	scrollsActives[skill.skilltype]=skill
	skill.start()
	updateHuds()
	

func updateHuds():
	var scroll
	for i in range(0,scrollHuds.size(),1):
		var sh=scrollHuds[i].scrollHud
		for j in range(0,scrollsActives.size(),1):
			scroll=sh.get_node("Scrolls").get_child(sAHudPosition[j])
			
			if scrollsActives[j]==null:
				scroll.visible=false
			else:
				scrollsActives[j].updateScroll(scroll)
				scroll.visible=true
				
		for j in range(0,scrollsPassives.size(),1):
			scroll=sh.get_node("Scrolls").get_child(sPHudPosition[j])
			
			if scrollsPassives[j]==null:
				scroll.visible=false
			else:
				scrollsPassives[j].updateScroll(scroll)
				scroll.visible=true
		
		scroll=sh.get_node("Selected")
		if (scrollSelected==null):
			scroll.visible=false
		else:
			getSelectedSroll().updateScroll(scroll)
					
		
func getSelectedSroll():
	var p
	
	for i in range(0,sAHudPosition.size(),1):
		p=sAHudPosition[i]
		if p==scrollSelected:
			return scrollsActives[i]
			
	for i in range(0,sPHudPosition.size(),1):
		p=sPHudPosition[i]
		if p==scrollSelected:
			return scrollsPassives[i]

