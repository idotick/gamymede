extends Control

@export var AUDIO_BUS: String = "Master"

signal change_requested(bus: String, value: float)

func _on_slider_value_changed(value: float) -> void:
	change_requested.emit(AUDIO_BUS, value / ($Slider.max_value - $Slider.min_value))

func _on_volume_updated(bus: String, value: float) -> void:
	if (bus != AUDIO_BUS):
		return
		
	$Slider.value = $Slider.min_value + ($Slider.max_value - $Slider.min_value) * value
