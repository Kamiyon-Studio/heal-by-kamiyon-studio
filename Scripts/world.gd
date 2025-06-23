extends Node2D

@export var player: CharacterBody2D
@export var camera_2d: Camera2D 
@export var background_music: AudioStreamPlayer2D 


func _ready() -> void:
	#background_music.play()
	pass

func _on_camera_up_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		camera_2d.base_zoom = Vector2(0.2, 0.2)
		camera_2d.reference_scale = Vector2(2.0, 2.0)
		print("player_entered!")


func _on_camera_up_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		camera_2d.base_zoom = Vector2(1.0, 1.0)
		camera_2d.reference_scale = Vector2(1.0, 1.0)
		print("player_exited!")


func _on_get_big_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("lumake")
		player.scale = Vector2(5.0, 5.0)
		
