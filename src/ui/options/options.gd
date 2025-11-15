extends Control

signal changed(value: bool)

func _ready() -> void:
	visible = false
	
func enter():
	visible = true
	changed.emit(visible)

func exit():
	visible = false
	changed.emit(visible)

func _on_pause_options_requested(value: bool) -> void:
	if (value):
		enter()
		return
	exit()

func _on_exit_button_pressed() -> void:
	exit()

func _on_game_options_changed(value: bool) -> void:
	if (value):
		return
		
	exit()
