extends Area2D

@export_multiline var box_text: String = "Hello! Welcome to the new room."
@export var ui_layer: CanvasLayer

# This variable tracks if we already played the sound
var has_played_sound: bool = false

func _ready() -> void:
	if ui_layer:
		ui_layer.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# 1. Handle the UI
		if ui_layer:
			var label = ui_layer.get_node("Panel/Label")
			if label:
				label.text = box_text
			ui_layer.show()
		
		# 2. Handle the Sound (Only plays once)
		if not has_played_sound:
			$AudioStreamPlayer2D.play()
			has_played_sound = true # Lock the sound so it won't play again
			# NOTICE: We removed set_deferred("monitoring", false) 
			# so the Area stays active for the exit signal!

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("Player has LEFT the area!") # This will show in the bottom Output window
		if ui_layer:
			ui_layer.hide()
