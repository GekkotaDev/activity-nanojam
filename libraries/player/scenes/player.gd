extends CharacterBody2D

@export var particles: GPUParticles2D

@export_group("Sounds")
@export var sound_boom: AudioStream


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var recoil_velocity = 150.0


func _physics_process(delta: float) -> void:
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
        #velocity += get_gravity() * delta
#
    ## Handle jump.
    #if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        #velocity.y = JUMP_VELOCITY
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
