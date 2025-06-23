extends Camera2D

@onready var player: CharacterBody2D = $"../Player"


@export var zone_size: Vector2 = Vector2(1280, 720) # size of one "screen" or section
@export var base_zoom: Vector2 = Vector2(1.0, 1.0)
@export var reference_scale: Vector2 = Vector2(1.0, 1.0)
@export var zoom_multiplier: float = 1.0
@export var ceiling_position: Vector2 = Vector2(5000, -12000)

var is_locked_to_ceiling: bool = false
var moving_to_ceiling := false

func _process(delta: float) -> void:
	if is_locked_to_ceiling or moving_to_ceiling:
		pass
	else:
	# ======= Zone-based Camera Movement =======
		var player_pos := player.global_position
		var zone_index := Vector2i(
			int(floor(player_pos.x / zone_size.x)),
			int(floor(player_pos.y / zone_size.y))
		)

		var target_position := Vector2(
			zone_index.x * zone_size.x + zone_size.x / 2,
			zone_index.y * zone_size.y + zone_size.y / 2
		)

		global_position = global_position.lerp(target_position, 10.0 * delta)

	# ======= Zoom Based on Player Scale =======
	var scale_ratio: Vector2 = Vector2(
		player.scale.x / reference_scale.x,
		player.scale.y / reference_scale.y
	)

	var inverse_scale: Vector2 = Vector2(
		1.0 / scale_ratio.x,
		1.0 / scale_ratio.y
	)

	var target_zoom: Vector2 = base_zoom * inverse_scale * zoom_multiplier
	zoom = zoom.lerp(target_zoom, 5.0 * delta)

func move_slowly_to_ceiling(duration := 5.0):
	if moving_to_ceiling:
		return  # Prevent re-triggering

	moving_to_ceiling = true
	var tween := get_tree().create_tween()
	tween.tween_property(self, "global_position", ceiling_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(Callable(self, "_on_camera_arrived_at_ceiling"))

func _on_camera_arrived_at_ceiling():
	is_locked_to_ceiling = true
	moving_to_ceiling = false
	player.can_move = true
