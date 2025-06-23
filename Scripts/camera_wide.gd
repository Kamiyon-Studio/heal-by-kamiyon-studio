extends Area2D

@export var camera_2d: Camera2D
@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Force zoom to match what it would be if player.scale = 3.0
		camera_2d.base_zoom = Vector2(0.2, 0.2)
		camera_2d.reference_scale = Vector2(2.0, 2.0)
		print("zoom out!")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		# Reset zoom behavior to normal
		camera_2d.base_zoom = Vector2(1.0, 1.0)
		camera_2d.reference_scale = Vector2(1.0, 1.0)
		print("zoom back!")
