extends Area2D
@export var speed = 200
@export var rotation_speed = 2.0


var screen_size
var direction = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var input = Input.get_axis("left","right")
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
	position.x+= delta * speed * direction.x
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if Input.is_action_pressed("left rotation"):
		rotation-=rotation_speed*delta
	if Input.is_action_pressed("right rotation"):
		rotation +=rotation_speed*delta

func show_message(text):
	$Level_up_label.text = text
	$Level_up_label.show()
	await get_tree().create_timer(.5,0).timeout
	$Level_up_label.hide() 
