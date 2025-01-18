extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
var player_killed: bool = false

func _ready():
	animation_player.play("EntryAnimation")

#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("player"):  # Confirm the player triggered the collision
		#print("1: Player detected.")
		#var collision_shape = shape_owner_get_owner(1)
		#print("Colliding shape name:", collision_shape.name)
		## Loop through the child nodes of the Area2D to find the triggering shape
		#for child in get_children():
			#if child is CollisionShape2D:
				#if child.name == "Killzone":
					#print("2: Killer shape detected.")
					#_handle_killer_shape_collision(body)
				#elif child.name == "DoorBlockShape":
					#print("3: Door block shape detected.")
					#_handle_door_block_collision(body)


func _handle_killer_shape_collision(body: Node2D) -> void:
	if player_killed:
		return
	player_killed = true
	if body.has_method("play_dying_animation"):
		body.play_dying_animation()
		timer.start()
		print("Timer started? ", not timer.is_stopped())  # Debug check for timer
		print("Player is dead")

#func _handle_door_block_collision(body: Node2D) -> void:
	#print("Player is blocked by the door.")
	#player_killed = false
	#var collision_center = global_position  # Position of the trap
	#var move_direction = (body.global_position - collision_center).normalized()  
	#var move_back = move_direction * 10  
	#body.position += move_back
	#
	## No need for additional logic. The physics engine handles the blocking.
	## Ensure the door's collision shape is set to block movement.

func _on_timer_timeout() -> void:
	print("Timer timed out, reloading scene...")
	get_tree().reload_current_scene()



func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.is_in_group("player"):  # Confirm the player triggered the collision
			print("1: Player detected.")
			var collision_shape = shape_owner_get_owner(local_shape_index)
			print("Colliding shape name:", collision_shape.name)
			if collision_shape.name == "Killzone":
				print("2: Killer shape detected.")
				_handle_killer_shape_collision(body)
			elif collision_shape.name == "DoorBlockShape":
				print("3: Door block shape detected.")
				#_handle_door_block_collision(body)
