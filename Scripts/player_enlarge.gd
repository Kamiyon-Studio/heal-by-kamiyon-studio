extends Area2D

@export var player: CharacterBody2D
@export var player_scale: Vector2 = Vector2(5.0,5.0)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player.large_to_small = true
		player.scale = player_scale
		print("player enlarge!")
		print(player.scale)
