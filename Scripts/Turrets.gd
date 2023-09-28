extends Node2D

var maxTurrets=5

func _process(delta):
	if (get_child_count()>maxTurrets):
		get_child(0).call_deferred("queue_free")
