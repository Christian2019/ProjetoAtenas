extends Node

var player
var Game

func timerCreator(functionName,time,parameters,node):
		var timer = Timer.new()
		timer.connect("timeout",Callable(self, "timeOut").bind(timer,node,functionName,parameters))
		timer.set_wait_time(time)
		timer.one_shot=true
		timer.autostart=true
		call_deferred("add_child",timer)
		
func timeOut(timer,node,functionName,parameters):
	remove_child(timer)
	call_deferred("doAction",node,functionName,parameters)
	
func doAction(node,functionName,parameters):
	if is_instance_valid(node) and !node.is_queued_for_deletion():
		node.callv(functionName,parameters)
