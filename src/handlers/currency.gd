extends Node

signal changed(currency: int)

@onready var currency: int:
	set(value):
		currency = value
		changed.emit(currency)
