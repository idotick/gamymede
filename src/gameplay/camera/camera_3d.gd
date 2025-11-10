extends Camera3D

@export var ray_length: int = 100

func get_cursor_hit():
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	var start = project_ray_origin(mouse_position)
	var end = start + project_ray_normal(mouse_position) * ray_length
	
	var query = PhysicsRayQueryParameters3D.new()
	
	query.from = start
	query.to = end
	query.collide_with_areas = true
	
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if (!result):
		return null
	
	var object = result.collider.get_parent()

	return {"hit": object, "position": result.position, "normal": result.normal}
