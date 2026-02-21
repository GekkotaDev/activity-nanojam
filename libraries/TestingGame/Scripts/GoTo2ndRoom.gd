extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player confirmed! Changing scene...")
		
		# Save the PLAYER'S Y position so they appear at the right height in the next room
		GlobalPlayerPosition.saved_player_position = body.global_position
		
		# Use call_deferred to change scenes safely at the end of the frame
		get_tree().call_deferred("change_scene_to_file", "res://libraries/TestingGame/Rooms/2nd_Room.tscn")
