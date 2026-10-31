extends Node2D
@export var shot_scene: PackedScene
@export var boss_scene: PackedScene
@export var vertical_speed = 48 
@export var horizontal_speed = 5
var direction = 1

var start_position = Vector2(400.0, 126.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_boss() -> void:
	hud.show_message("BOSS INCOMING!")
	await get_tree().create_timer(3.0).timeout
	print("Boss incoming!")
	var boss = boss_scene.instantiate()   # or a dedicated boss_scene
	position = start_position
	add_child(boss)
	
	
func on_boss_defeated() -> void:
	$MovementTimer.stop()
	$ShotTimer.stop()

func _on_left_wall_area_entered(area: Area2D) -> void:
	if direction < 0:
		direction *= -1
		position.y += vertical_speed


func _on_right_wall_area_entered(area: Area2D) -> void:
	if direction > 0:
		direction *= -1
		position.y += vertical_speed


func _on_bottom_wall_area_entered(area: Area2D) -> void:
	print("Game Over!")
	get_tree().call_deferred("reload_current_scene")


func _on_movement_timer_timeout() -> void:
	position.x += horizontal_speed * direction
	
func _on_shot_timer_timeout() -> void:
	var boss = get_node_or_null("Boss")
	if boss == null:
		return
	var shot = shot_scene.instantiate()
	get_tree().current_scene.add_child(shot)
	shot.global_position = boss.global_position + Vector2(0, 20)


		
