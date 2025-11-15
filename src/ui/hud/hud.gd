extends Control

func _ready() -> void:
	visible = true

func _on_pause_changed(value: bool) -> void:
	visible = !value
