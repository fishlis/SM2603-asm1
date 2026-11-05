class_name Shot
extends Area2D
@export var speed = 100
@export var direction = Vector2(0,-1)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction*delta*speed

func bounce():
	direction.x = -direction.x
	rotation = direction.angle()+PI/2

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_entered(area: Area2D) -> void:
	LiveCounter.lives -=1
	queue_free()
