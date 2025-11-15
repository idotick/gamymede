extends Node

@export_file_path("*.tscn") var MAIN_MENU_PATH: String = ""

signal pause_changed(value: bool)
signal options_changed(value: bool)

@onready var paused: bool = false
@onready var ui_opened: bool = false

func quit():
	assert(MAIN_MENU_PATH != "")
	get_tree().change_scene_to_file(MAIN_MENU_PATH)
	
func change_pausing(value: bool):
	paused = value
	pause_changed.emit(value)

func _on_exit_button_pressed() -> void:
	quit()

func _on_input_exit_requested() -> void:
	if (ui_opened):
		options_changed.emit(false)
		return
		
	change_pausing(!paused)

func _on_options_changed(value: bool) -> void:
	ui_opened = value
