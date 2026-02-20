extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Save Player Position
		GlobalPlayerPosition.saved_player_position = body.global_position
		
		# Ensure music is ready for the next room
		var sm = get_node_or_null("/root/SoundManager")
		if sm: sm.resume_music()
		
		# Change scene
		get_tree().call_deferred("change_scene_to_file", "res://libraries/TestingGame/Rooms/4th_Room.tscn")
