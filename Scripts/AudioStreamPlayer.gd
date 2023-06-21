extends AudioStreamPlayer

func _ready():
	play(random(0,stream.get_length()))

func random(min,max):
	var rng = RandomNumberGenerator.new()
	return int (rng.randf_range(min, max))
