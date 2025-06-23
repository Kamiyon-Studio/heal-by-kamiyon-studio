extends Area2D

@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.scale = Vector2(20.0, 20.0)
		print("player enlarge!")
