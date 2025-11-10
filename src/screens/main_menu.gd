extends Node2D

@export_file("*.tscn") var MAIN_SCENE_PATH: String

func enter_main():
	if !(FileAccess.file_exists(MAIN_SCENE_PATH)):
		printerr("Unable to access main scene from path %s?" % MAIN_SCENE_PATH)
		return
		
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)

func _on_button_pressed() -> void:
	enter_main()
