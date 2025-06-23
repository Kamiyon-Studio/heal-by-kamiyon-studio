extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

@export var start_x: float = 0.0
@export var end_x: float = 1000.0
@export var min_position : Vector2 = Vector2(5000, -13000)
@export var max_position : Vector2 = Vector2(100, 0)

@export var start_scale: Vector2 = Vector2(0.5, 0.5)
@export var end_scale: Vector2 = Vector2(1.0, 1.0)
@export var min_scale: float = 3.0
@export var max_scale: float = 7.0


const MAX_SPEED: float = 700.0
const ACCELERATION: float = 10.0
const FRICTION: float = 7.0
const ROTATION_SPEED: float = 7.0

var large_to_small: bool = false
var can_move: bool = true


# control player
func _physics_process(delta: float) -> void:
	if can_move:
		#print("Player scale:", self.scale)
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity


		var direction := Input.get_axis("left", "right")
		if direction:
			speed = min(speed + ACCELERATION, MAX_SPEED)
			velocity.x = direction * speed
		else:
			speed = 5
			velocity.x = move_toward(velocity.x, 0, FRICTION)
		
		# Rotation (like a rolling ball)
		if velocity.x != 0:
			rotation += sign(velocity.x) * ROTATION_SPEED * (abs(velocity.x) / MAX_SPEED) * delta
			
		move_and_slide()
	else:
		velocity = Vector2.ZERO

# change player size
func _process(_delta: float) -> void:
	update_scale_based_on_position()

	#if not large_to_small:
		#var t: float = clamp((global_position.x - start_x) / (end_x - start_x), 0.0, 1.0)
		#scale = start_scale.lerp(end_scale, t)
	#else:
		#pass

# Utility: maps value to 0..1 based on range
func inverse_lerp(a: float, b: float, v: float) -> float:
	if a == b:
		return 0.0
	return clamp((v - a) / (b - a), 0.0, 1.0)
	
func update_scale_based_on_position():
	var pos: Vector2 = global_position

	var x_factor: float = inverse_lerp(min_position.x, max_position.x, pos.x)
	var y_factor: float = inverse_lerp(min_position.y, max_position.y, pos.y)

	var blend: float = clamp(1.0 - (x_factor + y_factor) * 0.5, 0.0, 1.0)
	var scale_value: float = lerp(min_scale, max_scale, blend)

	scale = Vector2(scale_value, scale_value)
