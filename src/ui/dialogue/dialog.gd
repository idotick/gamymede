extends Control


@onready var enabled: bool = false:
	set(value):
		enabled = value
		visible = enabled
		
func _ready() -> void:
	visible = false

func play(data: Dictionary):
	var name: String = data.name
	var message: String = data.message
	var duration: float = data.duration
	
	$Name.text = name
	$Message.text = message

	enabled = true
	
	$AnimationPlayer.speed_scale = 5 / (duration + 1.5)
	$AnimationPlayer.play("on_message")

func _on_dialog_playing(data: Dictionary) -> void:
	play(data)
	
func _on_pause_changed(value: bool) -> void:
	visible = (!value) && enabled

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name != "on_message"):
		return
		
	enabled = false
