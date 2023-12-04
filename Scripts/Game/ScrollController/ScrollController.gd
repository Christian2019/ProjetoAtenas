extends Node2D

var scrollSelected=null

var scrollsActives=[null,null,null,null,null]
var sAHudPosition=[0,3,6,9,12]

var scrollsPassives=[null,null,null,null,null,null,null,null,null,null]
var sPHudPosition=[1,2,4,5,7,8,10,11,13,14]

var scrollHuds=[]

func newScroll(scroll):
	var ns=scroll.duplicate()
	ns.quality=scroll.quality
	ns.start()
	return ns
	

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.ScrollController=self
	Global.timerCreator("updateHuds",0.1,[],self)
	
func changeScrollPostion():
	if sAHudPosition.has(scrollSelected):
		var s = newScroll(getSelectedSroll())
		if addPassive(s):
			removeSelectedScroll(s)
	else:
		var s = newScroll(getSelectedSroll())
		if addActive(s):
			removeSelectedScroll(s)
		else:
			var s2= newScroll(scrollsActives[s.skilltype])
			scrollsPassives[sPHudPosition.find(scrollSelected)]=s2
			scrollsActives[s.skilltype]=s
			s.addActiveFunction()
			s.removePassiveFunction()
			s2.addPassiveFunction()

	scrollSelected=null		
	updateHuds()
		
	
func sell():
	var s= getSelectedSroll()
	Global.player.dracma+=s.sellPrice
	removeSelectedScroll(s)
	scrollSelected=null
	updateHuds()

func getCurrentScrollPrice(scroll):
	var baseValue =5
	var value = baseValue*(scroll.quality+1)*Global.WaveController.wave
	return value

func displayBig(scrollBig,selected,buttonPrice,equipButton):
	scrollSelected=selected
	var s=getSelectedSroll()
	if s==null:
		return false
	s.updateScroll(scrollBig)
	buttonPrice.text="sell "+str(s.sellPrice)
	if sAHudPosition.has(scrollSelected):
		equipButton.text="change to passive"
	else:
		equipButton.text="change to active"
	return true

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

func removeSelectedScroll(s):
	var p
	
	for i in range(0,sAHudPosition.size(),1):
		p=sAHudPosition[i]
		if p==scrollSelected:
			scrollsActives[i]=null
			s.removeActiveFunction()
			
	for i in range(0,sPHudPosition.size(),1):
		p=sPHudPosition[i]
		if p==scrollSelected:
			scrollsPassives[i]=null
			s.removePassiveFunction()

func addScroll(scroll):
	#Adicao Ativa
	if addActive(scroll):
		scrollSelected=null
		updateHuds()
		return true

	#Adicao Passiva
	if addPassive(scroll):
		scrollSelected=null
		updateHuds()
		return true
				
	if tryToCombine():
		return true
			
	return false

func addActive(scroll):
	if scrollsActives[scroll.skilltype]==null:
		scrollsActives[scroll.skilltype]=scroll
		scroll.start()
		scroll.addActiveFunction()
		return true
	return false
	
func addPassive(scroll):
	for i in range(0,scrollsPassives.size(),1):
		if (scrollsPassives[i]==null):
			scrollsPassives[i]=scroll
			scroll.start()
			scroll.addPassiveFunction()
			return true
	return false

func tryToCombine():
	return false
