extends Control

@onready var player = $AnimationPlayer

func _on_room_room_changed() -> void:
	player.play("room_transition")
