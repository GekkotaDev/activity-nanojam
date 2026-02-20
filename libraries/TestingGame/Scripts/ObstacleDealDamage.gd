extends Area2D

@export var damage_value: int = 10
@onready var timer = $Timer # Make sure the name matches your Timer node!

func _ready() -> void:
	# Connect our signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	timer.timeout.connect(_on_timer_timeout)

func _on_body_entered(body: Node2D) -> void:
	if "Player" in body.name:
		# Deal damage immediately on first touch
		deal_damage()
		# Start the repeating damage
		timer.start()

func _on_body_exited(body: Node2D) -> void:
	if "Player" in body.name:
		# Stop damaging when they leave
		timer.stop()
		print("Player left the spikes, stopping damage.")

func _on_timer_timeout() -> void:
	# This runs every 0.5 seconds while the player is inside
	deal_damage()

func deal_damage():
	GlobalPlayerHp.take_damage(damage_value)
	print("POISON/SPIKE DAMAGE! HP is now: ", GlobalPlayerHp.player_hp)
