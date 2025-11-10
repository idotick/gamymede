extends Node3D

@export_file("*.tscn") var BASE_ITEM_DROP_PATH: String

@onready var base_item_drop = load(BASE_ITEM_DROP_PATH)

func get_spread_offset(spread: float):
	return Vector3(randf_range(-.5, .5), 0, randf_range(-.5, .5)) * spread

func create(id: String, pos: Vector3):
	var item_drop = base_item_drop.instantiate()
	
	item_drop.id = id
	item_drop.name = id.capitalize()
	item_drop.position = pos
	
	add_child(item_drop)
	
func drop(id: String, pos: Vector3, amount: int = 1, spread: float = 0):
	if (amount <= 0):
		return
	
	for i in range(amount):
		create(id, pos + get_spread_offset(spread))
	
