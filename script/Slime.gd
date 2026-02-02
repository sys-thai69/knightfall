extends Node2D

const SPEED = 60.0
var direction = 1 # 1 = Right, -1 = Left

# Assuming RayCastRight is your FORWARD/WALL check
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
# Assuming RayCastDown is your EDGE check

func _process(delta: float) -> void:
    if ray_cast_right.is_colliding():
        direction = -1
        sprite.flip_h = true
    if ray_cast_down.is_colliding() == false:
        direction = 1
        sprite.flip_h = false
    
    position.x += direction * SPEED * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
