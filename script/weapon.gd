class_name Weapon
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	var cannon = get_tree().current_scene.get_node_or_null("Cannon")
	if cannon and cannon.has_method("show_message"):
		cannon.show_message("Press 'Q'!")
	queue_free()
