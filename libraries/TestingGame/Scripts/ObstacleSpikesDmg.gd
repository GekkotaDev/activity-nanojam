extends Area2D

@export var damage_amount: int = 5
@onready var damage_timer = $Timer # This requires a Timer node as a child
var player_in_range = null

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = body
		damage_timer.start()
		apply_damage() # Deal first hit

func _on_body_exited(_body: Node2D) -> void:
	player_in_range = null
	damage_timer.stop()

func _on_timer_timeout() -> void:
	apply_damage()

func apply_damage() -> void:
	Global.hp -= damage_amount
	Global.hp = clampi(Global.hp, 0, Global.max_hp)
	
	# Tell the player to refresh their bar
	if player_in_range and player_in_range.has_method("update_hp_ui"):
		player_in_range.update_hp_ui()
