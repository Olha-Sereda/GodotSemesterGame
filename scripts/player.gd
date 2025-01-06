extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var mainCharacter = $AnimatedSprite2D
var is_facing_left: bool = false
var is_dead: bool = false 

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		is_facing_left = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
		

	move_and_slide()
	
	# Determine animation state.
	if not is_on_floor():
		mainCharacter.animation = "jumping"
	elif velocity.x != 0:
		mainCharacter.animation = "running"
	else:
		mainCharacter.animation = "idle"
	
	var isLeft = velocity.x < 0
	mainCharacter.flip_h = is_facing_left
	
func play_dying_animation() -> void:
	is_dead = true # Prevent further movement and animation updates
	mainCharacter.animation = "dying"
