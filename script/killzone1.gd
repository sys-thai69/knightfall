extends Area2D


@onready var timer = $Timer




func _on_body_entered(body: Node2D) -> void:
    print("You died1")
    Engine.time_scale = 0.5
    body.get_node("CollisionShape2D").queue_free()
    timer.start() # Replace with function body.


func _on_timer_timeout() -> void:
    Engine.time_scale = 1
    get_tree().reload_current_scene() # Replace with function body.
