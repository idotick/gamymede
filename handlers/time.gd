extends Node
class_name GameTime

var tick_speed: float = 0.0
var time: float = 0.0

func get_time() -> float:
	return time

func get_tick_speed() -> float:
	return tick_speed

func set_time(value: float) -> void:
	if value < 0 or value > 1:
		push_error("invalid time value of [" + str(value) + "]")
		get_tree().quit(1)
		return
	
	time = value


func set_tick_speed(value: float) -> void:
	if value < 0 or value >= 1:
		push_error("invalid tick speed value of [" + str(value) + "]")
		get_tree().quit(1)
		return
	
	tick_speed = value
