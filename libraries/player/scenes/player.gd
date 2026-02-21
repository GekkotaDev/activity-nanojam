extends CharacterBody2D

@export var particles: GPUParticles2D

@export_group("Sounds")
@export var sound_boom: AudioStream
@onready var hp_bar = $HpBar
const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var recoil_velocity = 150.0


func _ready() -> void:
	print("!!! IF YOU SEE THIS, THE SCRIPT IS WORKING !!!")
	
	# Set the UI to match the Global value immediately
	if hp_bar:
		hp_bar.max_value = GlobalPlayerHp.player_max_hp
		hp_bar.value = GlobalPlayerHp.player_hp
		
	# Check if we are coming from a scene transition
	if GlobalPlayerPosition.saved_player_position != Vector2.ZERO:
		
		# --- ANTI-TRIGGER LOGIC ---
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		
		# 1. Capture the X where you placed this player in the 2nd Room editor
		# and add a small nudge (e.g., 50 pixels) to move them further right.
		var offset_x = 10.0 
		var editor_x = global_position.x + offset_x
		
		# 2. Capture the Y height from the previous room
		var exit_y = GlobalPlayerPosition.saved_player_position.y
		
		# 3. Apply them: New X (with offset), and Exit Y
		global_position = Vector2(editor_x, exit_y)
		
		# 4. Clear the global data
		GlobalPlayerPosition.saved_player_position = Vector2.ZERO
		
		print("SUCCESS: Player nudged right to: ", editor_x, " at Height: ", exit_y)
		
		# --- RE-ENABLE COLLISIONS ---
		await get_tree().create_timer(0.1).timeout
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
			
			
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("click"):
		# Get direction, normalize, and invert
		var dir = (get_global_mouse_position() - global_position).normalized()
		velocity = -dir * recoil_velocity
		particles.emitting = true
		SoundManager.play_sound(sound_boom)
		return move_and_slide()
	
	if is_on_floor():
		velocity = Vector2.ZERO

	## Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
#
	move_and_slide()


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
