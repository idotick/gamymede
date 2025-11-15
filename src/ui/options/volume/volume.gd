extends Control

@export var AUDIO_BUS: String = "Master"

signal change_requested(bus: String, value: float)

func _on_slider_value_changed(value: float) -> void:
	change_requested.emit(AUDIO_BUS,value / ($Slider.max_value - $Slider.min_value))
