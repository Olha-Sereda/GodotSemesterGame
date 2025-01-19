extends Area2D

@export var animation_speed: float = 100.0  # Speed of the transporter (pixels per second)
var player_on_escalator: CharacterBody2D = null  # Reference to the player standing on the transporter

@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D
@onready var collision_body = $StaticBody2D  # Reference to the StaticBody2D for collision

func _ready():
	# Set the animation playback speed based on the transporter speed
	animated_sprite.set_speed_scale(animation_speed / 100.0)  # Adjust scaling if needed
	animated_sprite.play()  # Start the escalator animation

	# Ensure collision_body is properly set (optional safeguard)
	assert(collision_body != null, "StaticBody2D (collision_body) is missing!")

func _physics_process(delta: float) -> void:
	if player_on_escalator:
		# Move the player horizontally based on the transporter speed
		print("Player is on transporter")
		player_on_escalator.global_position.x += animation_speed * delta

func _on_body_entered(body: Node2D) -> void:
	print("_on_body_entered")
	if not body.is_in_group("player"):
		print("Ignore non-player collisions") # Ignore non-player collisions
	if body.is_in_group("player"):  # Detect if the player steps onto the escalator
		print("1: Player detected.")
		player_on_escalator = body as CharacterBody2D
		print("Player is on the escalator.")

func _on_body_exited(body: Node2D) -> void:
	if body == player_on_escalator:  # Detect if the player steps off the escalator
		player_on_escalator = null
		print("Player has left the escalator.")
