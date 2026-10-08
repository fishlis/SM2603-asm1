class_name Shot
extends Area2D
@export var speed = 100



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta*speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	LiveCounter.lives -=1
	queue_free()
