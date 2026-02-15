extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# This will print to the console no matter what touches it
	print("!!! PHYSICS DETECTED: ", body.name)
	
	# If this works, we know the signal is fine. 
	# Then we can check if the name is actually "Player"
	if body.name == "Player":
		print("Player confirmed! Changing scene...")
		get_tree().change_scene_to_file("res://libraries/TestingGame/Rooms/3rd_Room.tscn")
