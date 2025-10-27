extends Node

signal pause_toggled

@onready var world = get_tree().current_scene.get_node("World")
@onready var camera: Camera3D = world.get_node("CameraAnchor/Camera3D")

func on_left_click():
	var result = camera.get_cursor_hit()
	
	if (!result):
		return
		
	var object_hit: Node3D = result.hit
	
	if (!object_hit.has_method("on_click")):
		return
	
	result.hit.on_click()
	
func on_right_click():
	return

func on_mouse_button_event(event: InputEventMouseButton):
	if (event.is_echo()):
		return
		
	match event.button_index:
		MOUSE_BUTTON_LEFT:
			on_left_click()
			
		MOUSE_BUTTON_RIGHT:
			on_right_click()
			
func on_key_event(event: InputEventKey):
	if (event.is_echo()):
		return
		
	if (!event.pressed):
		return
		
	if (event.keycode == KEY_ESCAPE):
		print('yes')
		pause_toggled.emit()
	
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		on_mouse_button_event(event)

	elif (event is InputEventKey):
		on_key_event(event)
	
	
