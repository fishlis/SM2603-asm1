extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateScore()
	pass

func show_message(text)-> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func updateScore()-> void:
	$Score.text = "Score: " + str(Global.score)
	


func _on_message_timer_timeout() -> void:
	$Message.hide()
	pass # Replace with function body.
