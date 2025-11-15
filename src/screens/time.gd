extends Label

@export var day_duration: float

@onready var known_time: float = 10

func clockerize(time: float):
	var total_minutes: int = floor(known_time / day_duration * 24 * 60)
	
	var hours: int = floor(total_minutes / 60)
	
	var minutes: int = total_minutes - (hours * 60)
	
	hours = hours % 12
	
	if (!hours):
		hours = 12

	return "%02d:%02d" % [hours, minutes]
	
func _process(delta: float) -> void:
	text = clockerize(known_time)
