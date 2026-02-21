extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player confirmed! Playing video scene...")
		
		# Save the PLAYER'S position
		GlobalPlayerPosition.saved_player_position = body.global_position
		
		# Point this to the .tscn file that contains your VideoStreamPlayer
		get_tree().call_deferred("change_scene_to_file", "res://libraries/TestingGame/Rooms/Trap_Room.tscn")
