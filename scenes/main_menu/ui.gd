extends SceneView

@export_group("Scenes")
@export var first_room: PackedScene

func _script(events: EventBus, _model):
	events.connect_of(
		"play",
		"pressed",
		func():
			# 1. Reset Player Position & HP
			GlobalPlayerPosition.saved_player_position = Vector2.ZERO
			GlobalPlayerHp.player_hp = GlobalPlayerHp.player_max_hp
			
			# 2. Reset NPC Following State
			# This ensures the NPC doesn't follow the player in a new game
			GlobalFollowNpcPosition.is_following = false
			
			# 3. Reset Background Music
			# If using the standard SoundManager, we stop current music 
			# so the first room can start its track fresh.
			if has_node("/root/SoundManager"):
				var sm = get_node("/root/SoundManager")
				sm.stop_music() 
				# If your SoundManager has a specific reset function, use that instead.
			
			SceneManager.change_scene(first_room)
	) 
	
	events.connect_of(
		"quit",
		"pressed",
		func():
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
			get_tree().quit()
	)
