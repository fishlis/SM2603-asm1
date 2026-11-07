extends Button

signal tutorial_requested

@onready var tutorial_button: Button = $tutorial_button

func _ready() -> void:
	tutorial_button.pressed.connect(_on_tutorial_button_pressed)

func _on_tutorial_button_pressed() -> void:
	tutorial_requested.emit()
