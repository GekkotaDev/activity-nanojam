extends Node

# Tracks if the NPC is currently tasked with following the player
var is_following: bool = false

# Stores the NPC's last position if you want it to spawn exactly where it left off
var saved_npc_position: Vector2 = Vector2.ZERO
