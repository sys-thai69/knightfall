extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
    print("you died!")
    timer.start()
    
    
     # Replace with function body.
