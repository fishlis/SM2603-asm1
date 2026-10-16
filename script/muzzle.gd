extends Node2D

@export var laser_scene: PackedScene
@onready var sfx_shoot: AudioStreamPlayer2D = $"../sfx_shoot"
var can_shoot = true



func _input(event):
	if Input.is_action_just_pressed("shoot") && can_shoot:
		var laser = laser_scene.instantiate()
		laser.global_position = get_parent().global_position + Vector2(0,-20)
		get_tree().root.get_node("Main").add_child(laser)
		can_shoot = false
		laser.tree_exited.connect(on_laser_destroyed)
		sfx_shoot.play()
		
func on_laser_destroyed():
	can_shoot = true
