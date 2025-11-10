extends Node

var items: Dictionary = {
	"wood": {"tags": ["material", "craftable", "fuel"]},
	"tree_seed": {"tags": ["seed", "fuel"]}
}

func exists(id: String):
	return items.has(id)

func applicable(id: String, tag: String):
	if (!exists(id)):
		return false
		
	var item: Dictionary = items[id]
	var tags: Array = item.tags
	
	return (tag in tags)
	
	
