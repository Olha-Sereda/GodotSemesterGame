extends Area2D

@onready var game_manager = %GameManadger


func _on_body_entered(body: Node2D) -> void:
	print("hello")
	if body.is_in_group("player"):
		queue_free()
		print("deleted from queue")
		game_manager.add_point()
		print("added point")
