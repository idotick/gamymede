extends Node

signal changed(new_data)

@export var item_limit: int = 99
@export var capacity: int = 40

@onready var inventory = []

func contains(id: String):
	return find(id) == -1

func find(id: String):
	for i in range(inventory.size()):
		if (inventory[i].id == id):
			return i
	return -1
	
func find_unfull(id: String):
	for i in range(inventory.size()):
		if (inventory[i].id != id):
			continue
			
		if (inventory[i].amount >= item_limit):
			continue
			
		return i
		
	return -1
	
func get_amount(id: String):
	var index: int = find(id)
	
	if (index == -1):
		return -1
		
	return inventory[index].amount
	
func create(id: String, amount: int):
	inventory.append({ "id": id, "amount": amount })

func add(id: String, amount: int):
	if (amount <= 0):
		return
		
	var index: int = find_unfull(id)
	
	if (index == -1):
		create(id, min(amount, item_limit))
		
		if (amount > item_limit):
			add(id, amount - item_limit)
		
		changed.emit(inventory)
		
		return
	
	if (inventory[index].amount + amount > item_limit):
		add(id, inventory[index].amount + amount - item_limit)
		
	inventory[index].amount = min(inventory[index].amount + amount, item_limit)
	
	changed.emit(inventory)
	
func deduct(id: String, amount: int):
	if (amount <= 0):
		return
		
	var index: int = find(id)
	
	if (index == -1):
		printerr("Failed to find item during deduction?")
		return
		
	if (inventory[index].amount <= amount):
		deduct(id, amount - inventory[index].amount)
		
		inventory.pop_at(index)
		
	changed.emit(inventory)
