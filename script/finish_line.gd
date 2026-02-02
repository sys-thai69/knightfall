extends Area2D
const WIN_SCREEN_SCENE = preload("res://scences/win_screen.tscn")

# Called when the node enters the scene tree for the first time

# Assuming your player's root node is a CharacterBody2D named "Player"
func _ready():
    # You can customize this if you need to set up anything initially
    pass

func _on_body_entered(body: Node2D) -> void:
    # 1. Check if the entering body is the Player
    # You can use 'is_in_group("player")' if you added your player to a group.
    if body.name == "Player" or body.name == "player": 
        # Or a more robust check:
        # if body is CharacterBody2D and body.get_parent().name == "Player":

        print("Player crossed the finish line!")
        
        # 2. Call a function to handle the win/level completion
        handle_win()

func handle_win():
    # Option A: Reload the level (quick and dirty restart)
    get_tree().paused = true
    
    # 2. Instantiate the Win Screen
    var win_screen = WIN_SCREEN_SCENE.instantiate()
    
    # 3. Add the screen to the root of the current scene tree
    get_tree().root.add_child(win_screen)
