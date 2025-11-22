extends Node

signal updated(bus: String, value: float)

var volumes: Dictionary = {
	"Master": 1,
	"Music": 1,
	"Effects": 1
}

@onready var handlers = get_parent()

@onready var settings_handler = handlers.get_node("Settings")

func setup():
	for bus in volumes.keys():
		set_bus_volume(bus, volumes[bus])
		
func request_volume(bus: String):
	if (!volumes.has(bus)):
		printerr("Unknown bus? ", bus)
		return 0
		
	return volumes[bus]
		
func request_bus_config(bus: String):
	var config_key: String = bus.to_lower() + "_volume"
	
	return settings_handler.request(config_key)
	
func load_config():
	for bus in volumes.keys():
		volumes[bus] = request_bus_config(bus)
		
func _ready() -> void:
	load_config()
	setup()
	
func set_bus_volume(bus: String, value: float) -> void:
	if (!volumes.has(bus)):
		printerr("Unknown bus? ", bus)
		return
		
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index(bus), value)
	volumes[bus] = value
	updated.emit(bus, value)
	
func _on_volume_change_requested(bus: String, value: float) -> void:
	set_bus_volume(bus, value)

func _on_music_volume_change_requested(bus: String, value: float) -> void:
	set_bus_volume(bus, value)

func _on_effect_volume_change_requested(bus: String, value: float) -> void:
	set_bus_volume(bus, value)
