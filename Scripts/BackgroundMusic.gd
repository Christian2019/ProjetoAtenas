extends AudioStreamPlayer

func _ready():
	var startTime = random(0,stream.get_length())
	play(startTime)
	print("Musica tempo de inicio: ",startTime,"s")

func random(min,max):
	var rng = RandomNumberGenerator.new()
	return int (rng.randf_range(min, max))
	volume_db
