extends Node

@export_file("*.json") var DIALOG_DATA_PATH: String

var data: Dictionary = {}

@onready var handlers = get_tree().current_scene.get_node("Handlers")

@onready var dialog_handler = handlers.get_node("Dialog")

@onready var previous_id: String = "none"

func load_data() -> void:
	if !(FileAccess.file_exists(DIALOG_DATA_PATH)):
		printerr("Unable to load dialog data from path %s?" % DIALOG_DATA_PATH)
		return
		
	var file: FileAccess = FileAccess.open(DIALOG_DATA_PATH, FileAccess.READ)
	
	var raw: String = file.get_as_text()
	
	file.close()
	
	var parsed = JSON.parse_string(raw)
	
	if !(parsed is Dictionary):
		printerr("Loaded item data is not a dictionary?")
		return
		
	data = parsed

func _ready() -> void:
	load_data()

func interact() -> void:
	if (previous_id == "none"):
		play("start")
		return
		
	var next_id: String = data[previous_id].next
	
	play(next_id)
		
func play(id: String) -> void:
	if (id == "end"):
		return
		
	if (!data.has(id)):
		printerr("Dialog id %s not found in dialog data?")
		return
		
	var data: Dictionary = data[id]
	
	dialog_handler.play(data)
	previous_id = id
		
	
