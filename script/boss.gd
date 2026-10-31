class_name Boss
extends Area2D
var HP = 10
@export var bossPoint = 500 # points player earns for killing boss
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("hit")
	HP -=1 
	if HP == 0: 
		print("Boss is Defeated")
		Global.score += bossPoint
		var invader_spawner = get_tree().current_scene.get_node_or_null("InvaderSpawner")
		if invader_spawner and invader_spawner.has_method("spawn_invaders"):
			invader_spawner.call_deferred("spawn_invaders")
		# stop the boss spawner's timers 
		var boss_spawner = get_tree().current_scene.get_node_or_null("BossSpawner")
		if boss_spawner and boss_spawner.has_method("on_boss_defeated"):
			boss_spawner.on_boss_defeated()
		queue_free()
		
	area.queue_free()
		
