extends Area2D

@onready var timer: Timer = $Timer
@export var camera_2d: Camera2D
@export var player: CharacterBody2D

var camera_ceiling_done = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		camera_2d.is_locked_to_ceiling = true
		
		timer.start()
		print("timer starts!")
		camera_2d.base_zoom = Vector2(0.2, 0.2)
		camera_2d.reference_scale = Vector2(2.0, 2.0)
		print("zoom out!")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		camera_2d.base_zoom = Vector2(1.0, 1.0)
		camera_2d.reference_scale = Vector2(1.0, 1.0)
		camera_2d.is_locked_to_ceiling = false
		print("zoom back!")


func _on_timer_timeout():
	if not camera_ceiling_done:
		print("timer ends - camera move!")
		player.can_move = false
		camera_2d.move_slowly_to_ceiling(5.0)
		await camera_2d
		print("camera move - finish!")
		
		camera_2d.is_locked_to_ceiling = false
		camera_2d.is_locked_to_ceiling = true
		camera_ceiling_done = true
		print("About to see the top")
	else:
		print("You already seen above")
		pass
	
