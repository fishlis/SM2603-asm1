extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	LiveCounter.lives=3
	
func _physics_process(delta):
	if LiveCounter.lives ==2:
		$live3.hide()
	if LiveCounter.lives ==1:
		$live2 .hide()
	if LiveCounter.lives ==0:
		get_tree().reload_current_scene()
