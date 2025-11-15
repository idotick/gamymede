extends Node

func set_bus_volume(bus: String, value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus), value)

func _on_volume_change_requested(bus: String, value: float) -> void:
	set_bus_volume(bus, value)

func _on_music_volume_change_requested(bus: String, value: float) -> void:
	set_bus_volume(bus, value)
