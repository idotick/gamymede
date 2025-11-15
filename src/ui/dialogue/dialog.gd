extends Control

func _ready() -> void:
	visible = false

func play(data: Dictionary):
	var name: String = data.name
	var message: String = data.message
	var duration: float = data.duration
	
	$Name.text = name
	$Message.text = message
	
	visible = true
	
	$AnimationPlayer.speed_scale = 5 / (duration + 1.5)
	$AnimationPlayer.play("on_message")

func _on_dialog_playing(data: Dictionary) -> void:
	play(data)
