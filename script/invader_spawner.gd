extends Node2D

@export var invader_scene: PackedScene
@export var shot_scene: PackedScene
@export var horizontal = 50
@export var vertical = 48
@export var rows = 4
@export var columns = 11
@export var vertical_speed = 48 
@export var horizontal_speed = 5

var start_position = Vector2(179.0, 75)
var direction = 1
var invaderCount = 0
func _ready() -> void:
	spawn_invaders()


func spawn_invaders():
	direction = 1
	invaderCount = 0
	position = start_position
	print("spawn")
	for r in rows:
		for c in columns:
			var invader = invader_scene.instantiate()
			invader.position = Vector2(c * horizontal, r * vertical)
			invaderCount +=1
			add_child(invader)    
			invader.tree_exited.connect(on_invader_killed)

func on_invader_killed()-> void:
	invaderCount -= 1
	if invaderCount == 0:
		print("All invaders killed!")
		spawn_invaders()
	
func _on_all_invaders_killed():
	pass
func _on_left_wall_area_entered(area: Area2D) -> void:
	if direction < 0:
		direction *= -1
		position.y += vertical_speed
		call_deferred("spawn_new_row")

func _on_right_wall_area_entered(area: Area2D) -> void:
	if direction > 0:
		direction *= -1
		position.y += vertical_speed

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
