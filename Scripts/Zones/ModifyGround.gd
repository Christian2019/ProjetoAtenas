extends AnimatedSprite2D

var precessFrame=0

var maxVisibility=1

var precessMaXframe=13*60

var started=false

func _process(delta):
	if (started):
		if (precessFrame==precessMaXframe):
			return
		
		modulate.a=(float(precessFrame)/float(precessMaXframe))*float(maxVisibility)
		precessFrame+=1


func start(ground, mV):
	precessFrame=ground
	started=true
	precessFrame=0
	visible=true
	maxVisibility=mV
	
	
func finish():
	visible=false
