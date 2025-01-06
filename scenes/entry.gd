extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
var player_killed: bool = false 


func _ready():
	animation_player.play("EntryAnimation")

func _on_body_entered(body: Node2D) -> void:
	if player_killed:
		return 
	if body.is_in_group("player"):
		player_killed = true
		if body.has_method("play_dying_animation"):
			body.play_dying_animation() 
			timer.start()
			print("Timer started? ", not timer.is_stopped()) # Debug check for timer

			print("Player is dead")

func _on_timer_timeout() -> void:
	print("Timer timed out, reloading scene...")
	get_tree().reload_current_scene()
