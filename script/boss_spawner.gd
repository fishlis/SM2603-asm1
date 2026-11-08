extends Node2D
@export var shot_scene: PackedScene
@export var boss_scene: PackedScene
@export var vertical_speed =  48 
@export var horizontal_speed = 5
@export var dual_offset := 28.0
@export var muzzle_down := 48.0
@export var sway_speed := 4.5
@export var sway_amount := 0.85
@export var fan_count := 3
@export var fan_spread := 0.9
@export var dual_fire_interval := 1.0
@export var fan_fire_interval := 2.0
var direction = 1
var sway_time := 0.0

var start_position = Vector2(400.0, 126.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	sway_time += delta

func spawn_boss() -> void:
	dual_fire_interval = 2.0 / Global.waveCount
	fan_fire_interval = 2.0 / Global.waveCount
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
	
func get_muzzle_position(boss: Node2D) -> Vector2:
	var sprite = boss.get_node_or_null("Sprite2D")
	var origin = sprite.global_position if sprite else boss.global_position
	return origin + Vector2(0, muzzle_down)


func spawn_shot_at(muzzle: Vector2, angle: float, offset: Vector2 = Vector2.ZERO) -> void:
	var shot = shot_scene.instantiate()
	get_tree().current_scene.add_child(shot)
	shot.direction = Vector2.DOWN.rotated(angle)
	shot.rotation = shot.direction.angle() + PI / 2.0
	shot.global_position = muzzle + offset


func _on_shot_timer_timeout() -> void:
	var boss = get_node_or_null("Boss")
	if boss == null:
		return

	var muzzle = get_muzzle_position(boss)
	if boss.HP <= 10:
		$ShotTimer.wait_time = fan_fire_interval
		var center_angle: float = sin(sway_time * sway_speed) * sway_amount
		var count: int = maxi(fan_count, 2)
		for i in count:
			var t: float = float(i) / float(count - 1)
			var angle: float = center_angle + lerpf(-fan_spread * 0.5, fan_spread * 0.5, t)
			spawn_shot_at(muzzle, angle)
	else:
		$ShotTimer.wait_time = dual_fire_interval
		spawn_shot_at(muzzle, 0.0, Vector2(-dual_offset, 0))
		spawn_shot_at(muzzle, 0.0, Vector2(dual_offset, 0))

		
