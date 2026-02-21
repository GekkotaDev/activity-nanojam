extends Node

signal health_changed(current, max_hp)

var player_hp: int = 100
var player_max_hp: int = 100

func take_damage(amount: int) -> void:
	player_hp -= amount
	player_hp = max (0, player_hp)
	# Tell the UI to update!
	health_changed.emit(player_hp, player_max_hp)
	
	if player_hp <=0:
		handle_player_death()

func handle_player_death():
	print("Player is dead!")
	
	# sends the player back to main menu
	SceneManager.change_scene(load("res://scenes/main_menu/main_menu.tscn"))
