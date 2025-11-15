@tool

extends Node3D

var sun_offset: float = 90.0
var moon_offset: float = sun_offset + 180.0

var time: float = 0

@export_category("Time")

@export var day_length: float = 420.0

@export_range(0.0, 1.0, 0.01) var start_time: float = 0.2:
	set(value):
		start_time = value
		time = start_time
		update_environment()
		
@export var ticking: bool = true
		
@export_category("Celestial Objects")

@export var sun_color: Gradient
@export var sun_intensity: Curve
@export var moon_color: Gradient
@export var moon_intensity: Curve

@export var top_color: Gradient:
	set(value):
		top_color = value
		update_environment()

@export var horizon_color: Gradient:
	set(value):
		horizon_color = value
		update_environment()

@onready var tick_speed: float = 1 / day_length

func _ready() -> void:
	tick_speed = 1 / day_length
	
	update_environment()

func update_environment() -> void:
	if (!has_node("Sun") || !has_node("Moon")):
		return

	$Sun.visible = $Sun.light_energy > 0
	$Moon.visible = $Moon.light_energy > 0
	
	$Sun.rotation_degrees.x = sun_offset + time * 360
	$Sun.light_color = sun_color.sample(time)
	$Sun.light_energy = sun_intensity.sample(time)
	
	$Moon.rotation_degrees.x = moon_offset + time * 360
	$Moon.light_color  = moon_color.sample(time)
	$Moon.light_energy = moon_intensity.sample(time)
	
	$World.environment.sky.sky_material.set("sky_top_color", top_color.sample(time))
	$World.environment.sky.sky_material.set("ground_bottom_color", top_color.sample(time))
	$World.environment.sky.sky_material.set("sky_horizon_color", horizon_color.sample(time))
	$World.environment.sky.sky_material.set("ground_horizon_color", horizon_color.sample(time))
	
	
func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		return
		
	if (!ticking):
		return
		
	time += tick_speed * delta
		
	if time >= 1.0:
		time = 0.0

	update_environment()
	
