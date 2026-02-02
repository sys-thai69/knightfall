extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

# --- NEW VARIABLES ---
var jump_count = 0
const MAX_JUMPS = 2
# ---------------------

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D # FIX 1: Defined sprite once

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta

    # --- JUMP/GRAVITY LOGIC ---
    if is_on_floor():
        jump_count = 0
    
    if Input.is_action_just_pressed("jump"):
        if is_on_floor() or jump_count < MAX_JUMPS:
            velocity.y = JUMP_VELOCITY
            jump_count += 1
            
            # Animation should play regardless of floor status when jump input is pressed
            if jump_count == 1:
                sprite.play("jump")
            else:
                sprite.play("jump1")
    # -----------------------------------

    # Get the input direction and handle the movement/deceleration.
    var direction := Input.get_axis("move_left", "move_right")
    
    if direction:
        velocity.x = direction * SPEED
        
        # Sprite Flipping Logic
        if direction > 0:
            sprite.flip_h = false
        elif direction < 0:
            sprite.flip_h = true
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    # --- ANIMATION LOGIC (FIXED) ---
    # FIX 2 & 3: Consolidated animation logic at the end and prioritized states.
    if not is_on_floor():
        # Check if the character is moving up (first jump) or falling (normal fall)
        # We don't change the animation if a jump animation is already playing mid-air
        if velocity.y > 0 and sprite.animation != "fall" and jump_count > 0:
            sprite.play("fall")
        elif velocity.y < 0 and sprite.animation != "jump" and sprite.animation != "jump1":
            # Keep jump animation playing while velocity is still upward
            pass 
        elif jump_count == 0 and velocity.y > 0:
            # If we fall off a ledge (jump_count=0)
            sprite.play("fall")
            
    elif direction != 0:
        # Playing run only if not jumping/falling and moving
        sprite.play("run")
        
    else:
        # Playing idle only if not jumping/falling and not moving
        sprite.play("idle")
    # --------------------------------

    move_and_slide()
