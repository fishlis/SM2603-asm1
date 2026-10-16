extends Node2D

var DMG_taken = 0
var spriteFrame = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	DMG_taken += 1
	print("Shield Damaged! HP: ", DMG_taken)
	spriteFrame += 1
	if spriteFrame < 8:
		$Sprite2D.set_frame(spriteFrame)
	else: 
		$Sprite2D.queue_free()
		$CollisionShape2D.queue_free()
	
