extends Node2D
func _ready() -> void:
	# This wakes up the music the moment the room loads
	if SoundManager:
		SoundManager.resume_music()
		# If it's still silent, try forcing a play:
		# SoundManager.play_music(preload("res://your_music_file.ogg"))
