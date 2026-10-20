class_name Invader
extends Area2D

@export var invader_count=0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("hit!")
	var spawner = get_tree().current_scene.get_node_or_null("WeaponSpawner")
	if spawner and spawner.has_method("kill"):
		spawner.kill()
		
	area.queue_free()
	queue_free()
	
   
