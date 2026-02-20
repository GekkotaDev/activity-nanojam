# HealthBar.gd
extends ProgressBar

func _ready() -> void:
	# 1. Initialize the bar with current global values
	max_value = GlobalPlayerHp.player_max_hp
	value = GlobalPlayerHp.player_hp
	
	# 2. Connect to the global signal
	GlobalPlayerHp.health_changed.connect(_on_health_updated)

func _on_health_updated(current: int, max_hp: int) -> void:
	# Update the bar's visuals
	max_value = max_hp
	value = current

func _process(_delta: float) -> void:
	# This forces the bar to match the global HP 60 times a second
	value = GlobalPlayerHp.player_hp
