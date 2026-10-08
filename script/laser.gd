extends Area2D

@export var speed = 400

func _process(delta):
	position.y -= delta*speed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
