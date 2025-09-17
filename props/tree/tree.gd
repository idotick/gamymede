extends Node3D

@export var initial_integrity: int = 10

@onready var world = get_tree().current_scene.get_node("World")

@onready var item_drops = world.get_node("Items")

@onready var integrity: int = initial_integrity:
	set(x):
		integrity = max(x, 0)
		
		if (integrity > 0):
			return
			
		fell()

@onready var invincible: bool = false

@onready var fallen: bool = false

func fell():
	if (fallen):
		return
		
	fallen = true
	
	var fall_right: bool = randi_range(0, 1)
	
	if (fall_right):
		$AnimationPlayer.play("FallRight")
	else:
		$AnimationPlayer.play("FallLeft")
		
func on_falling_finished():
	$Mesh.visible = false
	
	item_drops.drop("wood", global_position, 3, 1)
	
	queue_free()

func chop():
	if (invincible):
		return
	
	integrity -= 1
	
	if (integrity < 1):
		return
	
	$AnimationPlayer.play("Chop")
	
func set_invincibility(x):
	invincible = x
	
func on_click():
	chop()
