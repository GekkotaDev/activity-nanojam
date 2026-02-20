extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# This will print to the console no matter what touches it
	print("!!! PHYSICS DETECTED: ", body.name)
	
	# CHANGE IS HERE: Save the PLAYER'S position, not the Area2D's position
	# needs to the script Global.gd to be on the autoload in project settings
	Global.saved_player_position = global_position
	
	if body.name == "Player":
		print("Player confirmed! Changing scene...")
		get_tree().change_scene_to_file("res://libraries/TestingGame/Rooms/3rd_Room.tscn")
