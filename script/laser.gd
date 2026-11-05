extends Area2D

@export var speed = 400
@export var direction = Vector2(0,-1)

func _process(delta):
	position += direction*speed*delta

func bounce():
	direction.x=-direction.x
	rotation=direction.angle()+PI/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
