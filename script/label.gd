# CoinLabel.gd
extends Label
@onready var gamemanager: Node = $"../../Gamemanager"

func _ready():
    # Connect to the signal defined in the GameState Autoload
    gamemanager.coins_changed.connect(_on_coins_changed)

    # Set the initial text to the current coin count when the scene starts
    text = "Coins: %d" % gamemanager.current_coins

# This function is automatically called whenever GameState.add_coins() emits the signal
func _on_coins_changed(new_coin_count: int):
    text = "Coins: %d" % new_coin_count
