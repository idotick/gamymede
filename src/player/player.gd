extends CharacterBody3D

signal tile_changed

@export var movement_speed: float = 20

@export var tile_size: float = 2

@onready var grid_position: Vector2i = Vector2i.ZERO

@onready var move_direction: Vector2i = Vector2i.ZERO

func prioritize_axis(vec: Vector2, horizontal: bool = true):
	if (vec.x > 0 and horizontal):
		return Vector2(vec.x, 0)
		
	if (vec.y > 0 and not horizontal):
		return Vector2(vec.y, 0)
		
	return vec

func map_position(pos: Vector2):
	return Vector2i(round(pos.x), round(pos.y))
	
func map_global_position():
	return Vector2i(round(global_position.x / tile_size), round(global_position.z / tile_size))
	
func plane_to_3d(pos: Vector2):
	return Vector3(pos.x, 0, pos.y)

func halt(direction: Vector2i):
	if (direction != move_direction):
		return
		
	move_direction = Vector2i.ZERO

func handle_move_direction():
	if (Input.is_action_just_pressed("move_left")):
		move_direction = Vector2i.LEFT
		
	if (Input.is_action_just_pressed("move_right")):
		move_direction = Vector2i.RIGHT
		
	if (Input.is_action_just_pressed("move_forward")):
		move_direction = Vector2i.UP
		
	if (Input.is_action_just_pressed("move_backward")):
		move_direction = Vector2i.DOWN
		
	if (Input.is_action_just_released("move_left")):
		halt(Vector2i.LEFT)
		
	if (Input.is_action_just_released("move_right")):
		halt(Vector2i.RIGHT)
		
	if (Input.is_action_just_released("move_forward")):
		halt(Vector2i.UP)
		
	if (Input.is_action_just_released("move_backward")):
		halt(Vector2i.DOWN)

func handle_audio() -> void:
	if (move_direction != Vector2i.ZERO && !$WalkingAudio.playing):
		$WalkingAudio.play()
		
	if (move_direction == Vector2i.ZERO && $WalkingAudio.playing):
		$WalkingAudio.stop()
		
func _physics_process(delta: float) -> void:
	handle_move_direction()
	handle_audio()
	
	global_position = global_position.move_toward(plane_to_3d(Vector2(grid_position) * tile_size), movement_speed / tile_size * delta)
	
	if (map_global_position() == grid_position && move_direction != Vector2i.ZERO):
		grid_position += move_direction
