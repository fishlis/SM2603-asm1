extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartBtn.show()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateScore()

func show_message(text)-> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func updateScore()-> void:
	$Score.text = "Score: " + str(Global.score)
	
func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout
	
	$Message.text = "Press Start"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartBtn.show()

func _on_message_timer_timeout() -> void:
	$Message.hide()


func _on_start_btn_pressed() -> void:
	print("Start button presssed!")
	$StartBtn.hide()
	$StartBtn.visible = false
	start_game.emit()
