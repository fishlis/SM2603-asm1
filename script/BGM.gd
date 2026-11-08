extends Node2D
@onready var bgm: AudioStreamPlayer2D = $"Audio"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bgm.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func changeVolume(volume) -> void:
	bgm.volume_db = volume
