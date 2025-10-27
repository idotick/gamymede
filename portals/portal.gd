extends Node3D

class_name Portal

signal entered(room: String, id: String)

@export var id: String
@export var destination_room: String
@export var destination_id: String

func _on_area_entered(area: Area3D) -> void:
	entered.emit(destination_room, destination_id)

func _on_body_entered(body: Node3D) -> void:
	entered.emit(destination_room, destination_id)
