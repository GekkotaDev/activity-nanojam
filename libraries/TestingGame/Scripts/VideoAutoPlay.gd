extends VideoStreamPlayer

func _ready() -> void:
	# 1. Stop Global Music
	# We use 'get_node_or_null' so the game doesn't crash if the name is wrong
	var sm = get_node_or_null("/root/SoundManager")
	if sm:
		if sm.has_method("stop_music"):
			sm.stop_music()
		else:
			print("SoundManager found, but it doesn't have a 'stop_music' function!")
	
	# 2. Setup Video Display
	# This ensures the video fills the screen
	anchor_right = 1.0
	anchor_bottom = 1.0
	expand = true
	
	# Match window size
	var screen_size = get_viewport_rect().size
	size = screen_size
	
	# 3. Play and Connect
	play()
	finished.connect(_on_video_finished)

func _on_video_finished() -> void:
	print("Video finished, switching to menu...")
	# Verify this path matches your FileSystem exactly!
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
