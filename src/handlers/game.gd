extends Node

signal pause_changed(paused: bool)

@onready var paused: bool = false

func quit():
	get_tree().change_scene_to_file("res://screens/main_menu.tscn")

func _on_input_pause_toggled() -> void:
	paused = !paused
	pause_changed.emit(paused)

func _on_exit_button_pressed() -> void:
	quit()
