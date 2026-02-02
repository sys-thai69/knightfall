# GameState.gd
extends Node

# The current total number of coins the player has
var current_coins: int = 0

# A Godot Signal to notify other parts of the game when the coins change
# This is the key to automatically updating the Label!
signal coins_changed(new_coin_count)

func add_coins(amount: int):
    current_coins += amount
    # Emit the signal so the UI can update
    coins_changed.emit(current_coins)
    print("Coins: ", current_coins) # Optional: check the console

# res://script/gamemanager.gd


# 1. CONSTANT (Fixing the previous error)<-- Use the .tscn file path
# res://script/gamemanager.gd # Assuming your manager is a base Node
const PAUSE_MENU_SCENE = preload("uid://dms0s7esxb355")

# !!! IMPORTANT: MAKE SURE THIS PATH POINTS TO THE SCENE FILE (.tscn) !!!
var pause_menu_instance: CanvasLayer = null

func _unhandled_input(event: InputEvent) -> void:
    # 1. Listen for the 'pause' action (e.g., P or Escape key)
    if event.is_action_pressed("pause"):
        toggle_pause_menu()
        
func toggle_pause_menu():
    if get_tree().paused:
        # --- UNPAUSE LOGIC (If already paused) ---d
        get_tree().paused = false
        if pause_menu_instance:
            pause_menu_instance.queue_free() # Remove the menu instance
            pause_menu_instance = null
    else:
        # --- PAUSE LOGIC (If not paused) ---
        get_tree().paused = true
        
        # 2. Instantiate the menu SCENE
        pause_menu_instance = PAUSE_MENU_SCENE.instantiate()
        print("PAUSE MENU INSTANTIATED AND ADDED")
        # 3. Add the menu instance to the scene tree
        add_child(pause_menu_instance)
