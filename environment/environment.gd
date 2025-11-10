extends Node3D


@onready var sun: DirectionalLight3D = $Sun
@export var sun_color: Gradient
@export var sun_intensity: Curve
var sun_offset: float = 90.0

@onready var moon: DirectionalLight3D = $Moon
@export var moon_color: Gradient
@export var moon_intensity: Curve
var moon_offset: float

@onready var world: WorldEnvironment = $World
@export var top_color: Gradient
@export var horizon_color: Gradient

@export var day_length: float = 420.0
@export var start_time: float = 0.2
var tick_speed: float
var time: float


func _ready() -> void:
	tick_speed = (GlobalTime.get_tick_speed()
		 if GlobalTime.get_tick_speed() else 1 / day_length)
	time = (GlobalTime.get_time()
		 if GlobalTime.get_time() else start_time)
	
	GlobalTime.set_tick_speed(tick_speed)
	moon_offset = sun_offset + 180.0


func _process(delta: float) -> void:
	time += tick_speed * delta
	
	if time >= 1.0:
		time = 0.0
	
	GlobalTime.set_time(time)

	sun.visible = sun.light_energy > 0
	moon.visible = moon.light_energy > 0
	
	sun.rotation_degrees.x = sun_offset + time * 360
	sun.light_color = sun_color.sample(time)
	sun.light_energy = sun_intensity.sample(time)
	
	moon.rotation_degrees.x = moon_offset + time * 360
	moon.light_color  = moon_color.sample(time)
	moon.light_energy = moon_intensity.sample(time)
	
	world.environment.sky.sky_material.set("sky_top_color", top_color.sample(time))
	world.environment.sky.sky_material.set("ground_bottom_color", top_color.sample(time))
	world.environment.sky.sky_material.set("sky_horizon_color", horizon_color.sample(time))
	world.environment.sky.sky_material.set("ground_horizon_color", horizon_color.sample(time))
