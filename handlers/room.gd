extends Node3D

signal room_changed

signal room_built

var room_lib = {
	"town": preload("res://rooms/town.tscn"),
	"house": preload("res://rooms/house.tscn")
}

var current_room_id = "town"

@onready var world = get_tree().current_scene.get_node("World")
@onready var player = world.get_node("Player")

@onready var movement_allowed: bool = true

func shift_room():
	clear_room()
	setup_room()

func enter_portal(room: String, id: String):
	if not movement_allowed:
		return
	
	change_room(room)
	
	await room_built
	
	move_to_portal(id)

func delay_movement():
	movement_allowed = false
	$Timer.start()
	
func change_room(room_id: String):
	if not room_lib.has(room_id):
		printerr("Attempted to change room to unknown room?")
		return
		
	current_room_id = room_id
	
	room_changed.emit()
	
	delay_movement()
		
	$AnimationPlayer.play("room_transition")
	
func get_current_room():
	for node in get_children():
		if (node is Room):
			return node
	return null
	
func move_to_portal(portal_id: String):
	var room = get_node("Room")
	
	if not room:
		printerr("Failed to setup room before attempting to move player to portal?")
		return
	
	var portals = room.get_node("Portals").get_children()
	
	var index = -1
	
	for i in range(portals.size()):
		var portal = portals[i]
		
		if (portal.id == portal_id):
			index = i
			break
	
	if (index == -1):
		printerr("Failed to find portal while attempting to move player to portal?")
		return
	
	var portal = portals[index]
		
	player.global_position = portal.global_position
	
func clear_room():
	for node in get_children():
		if (node is Room):
			node.queue_free()

func setup_room():
	if not current_room_id:
		printerr("Attempted to setup non-existent room?")
		return
	
	if not room_lib.has(current_room_id):
		printerr("Attempted to setup unknown room?")
		return
		
	var packed_room: PackedScene = room_lib[current_room_id]
		
	var room = packed_room.instantiate()
	
	room.name = "Room"
	
	room.connect("portal_entered", enter_portal)
	
	add_child(room)
	
	room_built.emit()
	
func _ready() -> void:
	clear_room()
	setup_room()
	
func _on_timer_timeout() -> void:
	movement_allowed = true
