extends Area2D

@export var player: CharacterBody2D

@export var player_jump: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if player_jump < 4:
			player_jump += 1
			print("player jump:", player_jump)
		else:
			print("player teleport")
			player.global_position = Vector2(9641, -1454)
			player_jump = 0
