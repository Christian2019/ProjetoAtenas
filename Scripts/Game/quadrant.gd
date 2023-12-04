extends Area2D

var constructionArea=false

var tower

var allowToConstruct=false

#Numero de hits que deve ser dado antes de quebrar
var lifeMax=5
var life_till_break
var maxHpBarWidth

var level=0
var value=1

func _ready():
	$Level.modulate.a=0
	maxHpBarWidth=$BarraDeVida.size.x
	if ($Resource.animation=="gold"):
		$BarraDeVida.color = Color("FFD700")
	elif ($Resource.animation=="stone"):
		$BarraDeVida.color = Color("2c2d3c")
	elif ($Resource.animation=="wood"):
		$BarraDeVida.color = Color("966F33")
	if ($Resource.visible and !$BarraDeVida.visible):
		$BarraDeVida.visible=true
		
	if (level==1):
		lifeMax*=2
		value*=2
		$Level.modulate.a=0.2
	if (level==2):
		lifeMax*=4
		value*=4
		$Level.modulate.a=0.4
	
	life_till_break=lifeMax

func _process(_delta):
	permissions()
	lifebar()
	

func lifebar():
	$BarraDeVida.size.x=maxHpBarWidth*life_till_break/lifeMax

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
		
	if (area.get_parent().name=="Temple"):
		visible=false
		


func _on_area_exited(area):
	if (area.get_parent().name=="Player"):
		area.get_parent().contactQuadrants.erase(self)
		$ColorRect.visible=false
		

