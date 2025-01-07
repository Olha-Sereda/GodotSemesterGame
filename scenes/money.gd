extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("hello")
	if body.is_in_group("player"):
		queue_free()
		print("deleted from queue")
