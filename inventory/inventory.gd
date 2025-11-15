extends Control

@export var capacity: int = 0

@onready var items_container = $MarginContainer/Items

@onready var data = []

@onready var open: bool = false
@onready var open_allowed: bool = true

func _ready() -> void:
	visible = open
	
	items_container.set_capacity(capacity)
	items_container.reset()
	
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_inventory")):
		open = !open
		visible = open_allowed && open

func _on_inventory_changed(new_data) -> void:
	data = new_data
	items_container.update(data)

func _on_pause_changed(value: bool) -> void:
	open_allowed = !value
	visible = open_allowed && open
