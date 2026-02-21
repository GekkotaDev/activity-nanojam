extends Area2D

@export_multiline var box_text: String = "Hello! Welcome to the new room."
@export var ui_layer: CanvasLayer

# This tracks if the sound is CURRENTLY playing 
# to prevent it from restarting every frame while inside.
var is_playing_now: bool = false

func _ready() -> void:
	if ui_layer:
		ui_layer.hide()
	
	if has_node("AudioStreamPlayer2D"):
		$AudioStreamPlayer2D.finished.connect(_on_sfx_finished)

# --- Trigger logic ---
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# 1. Show the UI Text Box
		if ui_layer:
			var label = ui_layer.get_node_or_null("Panel/Label")
			if label:
				label.text = box_text
			ui_layer.show()
		
		# 2. Only trigger if we aren't already in the middle of playing it
		if not is_playing_now:
			_start_sfx_sequence()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if ui_layer:
			ui_layer.hide()
		
		# Optional: If you want the music to come back even if they 
		# leave before the sound finishes:
		# _on_sfx_finished() 

# --- Custom Logic Functions ---

func _start_sfx_sequence() -> void:
	is_playing_now = true
	
	# Pause Background Music
	var sm = get_node_or_null("/root/SoundManager")
	if sm and sm.has_method("pause_music"):
		sm.pause_music()
	
	$AudioStreamPlayer2D.play()

func _on_sfx_finished() -> void:
	# This runs when the AudioStreamPlayer2D hits the end of the file
	print("SFX finished! Resuming music and unlocking trigger...")
	
	# 1. Resume Background Music
	var sm = get_node_or_null("/root/SoundManager")
	if sm and sm.has_method("resume_music"):
		sm.resume_music()
	
	# 2. Reset the lock
	# Now, the next time the player enters (or if they are still inside 
	# and you want it to loop, you'd handle that here).
	is_playing_now = false
