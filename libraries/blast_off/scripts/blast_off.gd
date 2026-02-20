extends Area2D

@export var sound: AudioStream

func _ready() -> void:
	# This connects the signal to the function below
	body_entered.connect(_on_actual_collision, CONNECT_DEFERRED)

func _on_actual_collision(body: Node2D) -> void:
	# Check if the player is the one who entered
	if body.name == "Player":
		var sound_node := SoundManager.play_sound(sound)
		
		# Wait for sound to finish then quit
		sound_node.finished.connect(func(): get_tree().quit())
		
		var dialog := AcceptDialog.new()
		dialog.dialog_text = "YOU LOST!"
		dialog.confirmed.connect(func(): get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn"))
		
		add_child(dialog)
		dialog.popup_centered()
	else:
		print("Something else entered, ignoring: ", body.name)
''' this is the original code you had, I had to change it because it triggers a bug when Player enters
GoTo2ndRoom node and changes scene, it plays this script on the 2nd_Room scene then closes the game

extends Area2D



@export var sound: AudioStream





# Called when the node enters the scene tree for the first time.

func _ready() -> void:

body_entered.connect(

func(_0):

var sound := SoundManager.play_sound(sound)

sound.finished.connect(

func():

get_tree().quit()

)


var dialog := AcceptDialog.new()

dialog.dialog_text = "YOU LOST!"

dialog.custom_action.connect(

func(_0):

get_tree().quit()

)


add_child(dialog)

,

CONNECT_DEFERRED

)





# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:

pass

'''
