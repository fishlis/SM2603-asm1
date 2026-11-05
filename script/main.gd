extends Node2D

var score

#   when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.start_game.connect(_on_hud_start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func game_over():
	$ScoreTimer.stop()
	$MovementTimer.stop()
	$ShotTimer.stop()
	$HUD.show_game_over()
	

func _on_hud_start_game() -> void:
	score=0
	Global.score = 0
	$HUD.updateScore()
	hud.get_node("StartBtn").hide()
	get_tree().call_group("Invaders", "queue_free")
	
	var invader_spawner = get_node_or_null("InvaderSpawner")
	if invader_spawner and invader_spawner.has_method("spawn_invaders"):
		invader_spawner.spawn_invaders()
	


func _on_left_wall_area_entered(area: Area2D) -> void:
	if area.has_method("bounce"):
		area.bounce()



func _on_right_wall_area_entered(area: Area2D) -> void:
	if area.has_method("bounce"):
		area.bounce()
