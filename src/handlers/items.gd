extends Node

@export_file("*.json") var ITEM_DATA_PATH: String

@onready var items: Dictionary = {
	"wood": {"tags": ["material", "craftable", "fuel"]},
	"tree_seed": {"tags": ["seed", "fuel"]}
}

func load_data() -> void:
	if !(FileAccess.file_exists(ITEM_DATA_PATH)):
		printerr("Unable to load item data from path %s?" % ITEM_DATA_PATH)
		return
		
	var file: FileAccess = FileAccess.open(ITEM_DATA_PATH, FileAccess.READ)
	
	var raw: String = file.get_as_text()
	
	file.close()
	
	var parsed = JSON.parse_string(raw)
	
	if !(parsed is Dictionary):
		printerr("Loaded item data is not a dictionary?")
		return
		
	items = parsed
	
func _ready() -> void:
	load_data()

func exists(id: String):
	return items.has(id)

func applicable(id: String, tag: String):
	if (!exists(id)):
		return false
		
	var item: Dictionary = items[id]
	var tags: Array = item.tags
	
	return (tag in tags)
	
	
