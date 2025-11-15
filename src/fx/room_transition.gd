extends Control

@onready var player = $AnimationPlayer

func _ready() -> void:
	visible = true

func _on_room_room_changed() -> void:
	player.play("room_transition")
