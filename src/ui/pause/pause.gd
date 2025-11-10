extends Control

func _ready() -> void:
	visible = false

func _on_game_pause_changed(paused: bool) -> void:
	visible = paused
