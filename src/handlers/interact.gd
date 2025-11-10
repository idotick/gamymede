extends Node

@export var INTERACTABLE_DISTANCE: float

@onready var world = get_tree().current_scene.get_node("World")

@onready var room_handler: Node3D = world.get_node("Room")

@onready var player = world.get_node("Player")

func find_nearest(candidates):
	var index: int = 0
	var best_heuristic: int = -1
	
	for i in range(1, candidates.size() + 1):
		var sq_distance: float = (candidates[i-1].global_position - player.global_position).length_squared()
		
		if ((!index) || (sq_distance < best_heuristic)):
			index = i
			best_heuristic = sq_distance
			
	if (index):
		return candidates[index-1]
		
	return null

func attempt_interact() -> void:
	var room: Node3D = room_handler.get_current_room()
	
	if (!room):
		printerr("Unable to access room for interaction?")
		return
	
	var characters = room.get_node("Characters")
	
	var candidates = characters.get_children()
		
	var nearest = find_nearest(candidates)
	
	if (!nearest):
		return
		
	if (!nearest.has_method("interact")):
		return
		
	nearest.interact()

func _on_input_interact_requested() -> void:
	attempt_interact()
