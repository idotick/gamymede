extends Node

@export_file_path("*.cfg") var CONFIG_FILE_PATH: String

@onready var handlers = get_parent()

@onready var volume_handler = handlers.get_node("Volume")

@onready var config: Dictionary = {
	"master_volume": { "value": 1, "default": 1, "src": volume_handler.request_volume, "key": "Master" },
	"music_volume": { "value": 1,  "default": 1, "src": volume_handler.request_volume, "key": "Music"},
	"effects_volume": { "value": 1,  "default": 1, "src": volume_handler.request_volume, "key": "Effects"},
};

func apply_defaults() -> void:
	for key in config.keys():
		config[key].value = config[key].default

func save_data() -> void:
	var config_file: ConfigFile = ConfigFile.new()
	
	for key in config.keys():
		var value = config[key].value;
		config_file.set_value("main", key, value)
	
	var error = config_file.save(CONFIG_FILE_PATH)
	
	if (error):
		printerr("Error while saving config settings: ", error)
		return
		
func update_data() -> void:
	for key in config.keys():
		var value = config[key].src.call(config[key].key)
		
		config[key].data = value
	
func load_data():
	var config_file: ConfigFile = ConfigFile.new()
	
	var error = config_file.load(CONFIG_FILE_PATH)
	
	if (error):
		printerr("Error while loading config settings: ", error)
		return
	
	for key in config.keys():
		config[key].value = config_file.get_value("main", key, config[key].default)
		
func request(key: String):
	return config[key].value

func setup() -> void:
	if (!FileAccess.file_exists(CONFIG_FILE_PATH)):
		return
	
	load_data()
	
func _ready() -> void:
	setup()


func _on_game_settings_save_requested() -> void:
	save_data()


func _on_volume_updated(_bus: String, _value: float) -> void:
	update_data()
