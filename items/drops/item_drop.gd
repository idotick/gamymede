extends Node3D

@export var id: String

@onready var handlers = get_tree().current_scene.get_node("Handlers")

@onready var inventory = handlers.get_node("Inventory")

func on_pickup():
	inventory.add(id, 1)
	queue_free()

func on_click():
	on_pickup()

func _ready() -> void:
	$AnimationPlayer.play("Drop")


func _on_area_3d_mouse_entered() -> void:
	$Label3D.visible = true


func _on_area_3d_mouse_exited() -> void:
	$Label3D.visible = false
