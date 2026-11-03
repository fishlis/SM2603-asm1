extends Node2D
@export var laser_scene: PackedScene
@export var power_laser_scene: PackedScene
@onready var sfx_shoot: AudioStreamPlayer2D = $"../sfx_shoot"
var can_shoot = true
var press_time: float = 0.0
var power_timer_started: bool = false
func _process(delta: float)-> void:
	if Input.is_action_pressed("shoot"):
		press_time+=delta
	else:
		press_time = 0.0
func _input(event):
	if Input.is_action_pressed("shoot") && can_shoot:
		var current_laser_scene = laser_scene
		var used_power_shot = false
		if Global.has_power_shot and power_laser_scene:
			current_laser_scene = power_laser_scene
			used_power_shot = true
		var laser = current_laser_scene.instantiate()
		laser.global_position = get_parent().global_position + Vector2(0,-20)
		get_tree().root.get_node("Main").add_child(laser)
		can_shoot = false
		if used_power_shot and not power_timer_started:
			power_timer_started = true
			start_power_shot_countdown()
		await get_tree().create_timer(0.5).timeout   # cooldown
		can_shoot = true
		sfx_shoot.play()
func start_power_shot_countdown() -> void:
	await get_tree().create_timer(3.0).timeout
	Global.has_power_shot = false
	power_timer_started = false

func on_laser_destroyed():
	can_shoot = true
