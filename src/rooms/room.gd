extends Node3D

class_name Room

signal portal_entered(room: String, id: String)

func enter_portal(room: String, id: String):
	portal_entered.emit(room, id)

func _ready() -> void:
	var portals = $Portals.get_children()
	
	for portal in portals:
		portal.connect("entered", enter_portal)
