extends ProgressBar

func _ready() -> void:
	# Find the player in the scene
	var player = get_tree().root.find_child("Player", true, false)
	
	if player:
		# Connect the bar to the player's signal
		player.health_changed.connect(_on_player_health_changed)
		# Set initial value
		max_value = player.max_health
		value = player.current_health

func _on_player_health_changed(new_health: int):
	value = new_health
