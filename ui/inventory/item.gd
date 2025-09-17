extends Control

@export var id: String:
	set(x):
		id = x
		
		$Texture.visible = id != "none"

@export var amount: int = 0:
	set(x):
		amount = max(x, 0)
		
		$Label.text = str(amount)
		
		$Label.visible = amount > 0
		
func _ready() -> void:
	id = "none"
	amount = 0
