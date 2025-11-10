extends Node
class_name GameTime

var SECONDS_IN_DAY: float = 86400
var SECONDS_TO_MIN: float = 60
var SECONDS_TO_HOUR: float = 3600

var tick_speed: float
var time: float

func get_game_seconds() -> float:
	return SECONDS_IN_DAY * time

func get_clock() -> Dictionary[String, int]:
	var clock: Dictionary[String, int] = {
		"hour": 0,
		"minute": 0,
		"second": 0,
	}
	
	clock["hour"] = int(get_game_seconds() / SECONDS_TO_HOUR)
	clock["minute"] = int((get_game_seconds()
		- (clock["hour"] * SECONDS_TO_HOUR))
		/ SECONDS_TO_MIN)
	clock["second"] = int(get_game_seconds()
		- (clock["hour"] * SECONDS_TO_HOUR)
		- (clock["minute"] * SECONDS_TO_MIN))
	
	return clock
	
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
