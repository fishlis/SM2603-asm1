class_name PowerShot
extends Area2D
@export var speed = 200
@export var shot_count: int= 10
@export var lifetime: float = 2.0

func ready()-> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= delta*speed


func _on_area_entered(area: Area2D) -> void:
	if area.name.contains("Cannon") or area.name.contains("Shield"):
		return


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
