extends Control

@export var capacity: int = 0

@onready var items_container = $MarginContainer/Items

@onready var data = []

func _ready() -> void:
	visible = false
	
	items_container.set_capacity(capacity)
	items_container.reset()
	
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_inventory")):
		visible = !visible

func _on_inventory_changed(new_data) -> void:
	data = new_data
	items_container.update(data)
	
	
