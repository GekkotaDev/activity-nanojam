extends CharacterBody2D

@export var speed: float = 160.0
@export var stop_distance: float = 60.0 

var player: Node2D = null
var following: bool = false

func _ready() -> void:
	# 1. IMMEDIATE CHECK: Is the NPC already following?
	if GlobalFollowNpcPosition.is_following:
		# --- FOLLOWING MODE (SCENE TRANSITION) ---
		# Only hide and disable if we are actually about to teleport
		visible = false
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		
		# Give the room 1 second to settle (per your preference)
		await get_tree().create_timer(3.0).timeout
		_sync_to_player_final()
	else:
		# --- WAITING MODE (FIRST MEETING) ---
		# Do NOT hide. Do NOT disable physics. 
		# Stay as a child of the room so (0,14) is inside the walls.
		set_as_top_level(false) 
		visible = true
		following = false
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		print("NPC is waiting. Walk into Area2D to recruit.")

func _sync_to_player_final() -> void:
	player = get_tree().root.find_child("Player", true, false)
	
	if player:
		# Force Top Level to ignore the scene's (0,0) offset
		set_as_top_level(true)
		
		# Snap directly to the player's side
		global_position = player.global_position + Vector2(-45, 0)
		
		following = true
		visible = true
		
		# Turn physics back on now that we are past the boundary
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
		print("NPC synced to player side.")
	else:
		visible = true
		print("NPC Error: Player not found.")

func _physics_process(_delta: float) -> void:
	if not following:
		return
		
	if player == null:
		player = get_tree().root.find_child("Player", true, false)
		return

	var dist = global_position.distance_to(player.global_position)
	if dist > stop_distance:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Recruitment logic
		GlobalFollowNpcPosition.is_following = true
		player = body
		following = true
		print("NPC Recruited!")
