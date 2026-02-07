extends SceneView

@export_group("Scenes")
@export var first_room: PackedScene


func _script(events: EventBus, _model):
    events.connect_of(
        "play",
        "pressed",
        func():
            SceneManager.change_scene(first_room)
    )
    
    events.connect_of(
        "quit",
        "pressed",
        func():
            get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
            get_tree().quit()
    )
