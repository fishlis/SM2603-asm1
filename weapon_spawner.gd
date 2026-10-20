extends Node2D

@export var weapon_scene: PackedScene
@export var shot_scene: PackedScene
@export var horizontal = 48
@export var vertical = 48
@export var rows = 1
@export var columns = 1
@export var vertical_speed = 10
@export var horizontal_speed = 10
var invader_count =0

var direction = 1


func spawn_weapon():
	print("spawn weapon")
	for r in rows:
		for c in columns:
			var weapon = weapon_scene.instantiate()
			weapon.global_position = global_position + Vector2(c * horizontal, r * vertical)
			get_tree().current_scene.add_child(weapon)

func kill()->void:
	invader_count+=1
	if invader_count>=5:
		print(invader_count)
		spawn_weapon()
		invader_count=0



func _on_shot_timer_timeout() -> void:

	var i = get_children().filter(func(inv): return inv is Invader).pick_random()
	var shot = shot_scene.instantiate()
	shot.global_position = i.global_position + Vector2(0,20)
	get_tree().current_scene.add_child(shot)
