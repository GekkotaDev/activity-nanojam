extends SceneView

@export_group("Scenes")
@export var first_room: PackedScene

func _script(events: EventBus, _model):
	events.connect_of(
		"play",
		"pressed",
		func():
			# Reset the global position so the player starts at the 
			# default editor position in the first room.
			Global.saved_player_position = Vector2.ZERO
			
			SceneManager.change_scene(first_room)
	) # This closes the "play" connection
	
	events.connect_of(
		"quit",
		"pressed",
		func():
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()
	) 
