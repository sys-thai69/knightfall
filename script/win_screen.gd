# res://ui/win_screen.gd
extends CanvasLayer

func _on_restart_pressed() -> void:
    get_tree().paused = false
    get_tree().change_scene_to_file("res://scences/game.tscn")
    queue_free()
    
func _on_exit_pressed() -> void:
    get_tree().quit()
