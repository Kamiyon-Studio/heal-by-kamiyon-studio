extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

@export var start_x: float = 0.0
@export var end_x: float = 1000.0
@export var start_scale: Vector2 = Vector2(0.5, 0.5)
@export var end_scale: Vector2 = Vector2(1.0, 1.0)

const MAX_SPEED: float = 700.0
const ACCELERATION: float = 10.0
const FRICTION: float = 7.0
const ROTATION_SPEED: float = 7.0


# control player
func _physics_process(delta: float) -> void:
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

# change player size
func _process(_delta: float) -> void:
	var t: float = clamp((global_position.x - start_x) / (end_x - start_x), 0.0, 1.0)
	scale = start_scale.lerp(end_scale, t)
