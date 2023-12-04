extends Node2D

var scrollsActives=[null,null,null,null]

var scrollsPassives=[null,null,null,null,null,null]

var scrollHuds=[]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.ScrollController=self

func _process(delta):
	pass

func update():
	pass
