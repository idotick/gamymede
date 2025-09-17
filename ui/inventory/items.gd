extends GridContainer

@export var capacity: int = 0

var base_item = preload("res://ui/inventory/item.tscn")

func set_capacity(new_capacity: int):
	capacity = new_capacity

func create_item(index: int):
	var item: Control = base_item.instantiate()
	
	item.name = "Item" + str(index + 1)
	
	call_deferred("add_child", item)
	
func get_item(index: int):
	return get_node("Item" + str(index + 1))

func set_item(index: int, id: String, amount: int):
	var item = get_item(index)
	
	if (!item):
		printerr("Nonexistent ui item inventory?")
		return
		
	item.id = id
	item.amount = amount
	
func update(data):
	for i in range(data.size()):
		if (i >= capacity):
			printerr("Inventory UI capacity overflow?")
			return
			
		set_item(i, data[i].id, data[i].amount)

func clear():
	for child in get_children():
		child.queue_free()

func fill():
	for i in range(capacity):
		create_item(i)

func reset():
	clear()
	fill()
