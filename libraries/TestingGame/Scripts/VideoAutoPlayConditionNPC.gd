extends VideoStreamPlayer

# Drag your video files into these slots in the Inspector
@export var video_with_npc: VideoStream
@export var video_alone: VideoStream

func _ready() -> void:
	# 1. Handle SoundManager
	var sm = get_node_or_null("/root/SoundManager")
	if sm and sm.has_method("stop_music"):
		sm.stop_music()
	
	# 2. Display Logic
	anchor_right = 1.0
	anchor_bottom = 1.0
	expand = true
	size = get_viewport_rect().size
	
	# 3. SELECT VIDEO BASED ON NPC STATUS
	if GlobalFollowNpcPosition.is_following == true:
		print("NPC is following: Loading Video 1")
		stream = video_with_npc
	else:
		print("NPC is NOT following: Loading Video 2")
		stream = video_alone
	
	# 4. Play and Connect
	if stream:
		play()
	else:
		print("Error: No video stream assigned!")
		_on_video_finished() # Skip to menu if video is missing
		
	finished.connect(_on_video_finished)

func _on_video_finished() -> void:
	print("Video finished, switching to menu...")
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
