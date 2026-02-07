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
