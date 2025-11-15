extends Control

signal changed(value: bool)
signal options_requested(value: bool)

@onready var paused: bool = false

func _ready() -> void:
	visible = false
	
func enter():
	paused = true
	visible = paused
	changed.emit(paused)
	
func exit():
	paused = false
	visible = paused
	changed.emit(paused)

func _on_game_pause_changed(value: bool) -> void:
	if (value):
		enter()
		return
	exit()
	
func _on_options_button_pressed() -> void:
	options_requested.emit(true)
	
func _on_options_changed(value: bool) -> void:
	visible = (!value) && paused
