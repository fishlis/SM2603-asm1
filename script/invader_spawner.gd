extends Node2D

@export var invader_scene: PackedScene
@export var shot_scene: PackedScene
@export var horizontal = 48
@export var vertical = 48
@export var rows = 3
@export var columns = 15
@export var vertical_speed = 48 
@export var horizontal_speed = 10

var direction = 1
var spawnedRows = 1



func _ready() -> void:
	spawn_invaders()


func spawn_invaders():
	print("spawn")
	for r in rows:
		for c in columns:
			var invader = invader_scene.instantiate()
			invader.position = Vector2(c * horizontal, r * vertical)
			add_child(invader)

func spawn_new_row():
	for c in columns: 	
		var invader = invader_scene.instantiate()
		invader.position = Vector2(c * horizontal, 0 - spawnedRows * vertical)
		add_child(invader)
	print("new row spawned")
	spawnedRows+=1

func _on_left_wall_area_entered(area: Area2D) -> void:
	if direction < 0:
		direction *= -1
		position.y += vertical_speed
		spawn_new_row()

func _on_right_wall_area_entered(area: Area2D) -> void:
	if direction > 0:
		direction *= -1
		position.y += vertical_speed
		spawn_new_row()

func _on_movement_timer_timeout() -> void:
	position.x += horizontal_speed * direction


func _on_bottom_wall_area_entered(area: Area2D) -> void:
	print("Game Over!")
	get_tree().call_deferred("reload_current_scene")


func _on_shot_timer_timeout() -> void:

	var i = get_children().filter(func(inv): return inv is Invader).pick_random()
	var shot = shot_scene.instantiate()
	shot.global_position = i.global_position + Vector2(0,20)
	get_tree().current_scene.add_child(shot)
