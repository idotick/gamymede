extends CharacterBody3D

class_name Character

signal tile_changed

@export var MOVEMENT_SPEED: float = 20

@export var TILE_SIZE: float = 2

@onready var grid_position: Vector2i = Vector2i.ZERO

@onready var move_direction: Vector2i = Vector2i.ZERO

func interact():
	if (has_node("Dialog")):
		var dialog = get_node("Dialog")
		dialog.interact()
		
func prioritize_axis(vec: Vector2, horizontal: bool = true):
	if (vec.x > 0 and horizontal):
		return Vector2(vec.x, 0)
		
	if (vec.y > 0 and not horizontal):
		return Vector2(vec.y, 0)
		
	return vec

func gridify(pos: Vector2):
	return Vector2i(round(pos.x), round(pos.y))
	
func map_global_position():
	return Vector2i(round(global_position.x / TILE_SIZE), round(global_position.z / TILE_SIZE))

func map_position(pos: Vector3):
	return Vector2i(round(pos.x / TILE_SIZE), round(pos.z / TILE_SIZE))
	
func plane_to_3d(pos: Vector2):
	return Vector3(pos.x, 0, pos.y)
	
func plane_from_3d(pos: Vector3):
	return Vector2(pos.x, pos.z)

func teleport(pos: Vector3):
	grid_position = map_position(pos)
	
	global_position = plane_to_3d(Vector2(grid_position) * TILE_SIZE)
	
	move_direction = Vector2i.ZERO

func halt(direction: Vector2i):
	if (direction != move_direction):
		return
		
	move_direction = Vector2i.ZERO

func handle_move_direction():
	pass

func _ready():
	grid_position = gridify(plane_from_3d(global_position))
		
func _physics_process(delta: float) -> void:
	handle_move_direction()
	
	global_position = global_position.move_toward(plane_to_3d(Vector2(grid_position) * TILE_SIZE), MOVEMENT_SPEED / TILE_SIZE * delta)
	
	if (map_global_position() == grid_position && move_direction != Vector2i.ZERO):
		grid_position += move_direction
