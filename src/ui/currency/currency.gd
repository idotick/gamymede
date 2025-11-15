extends Label

@onready var known_currency: int = 0:
	set(value):
		text = str(known_currency)

func _on_currency_changed(currency: int) -> void:
	known_currency = currency
