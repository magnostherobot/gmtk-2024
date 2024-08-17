extends Node2D

@export var player_hand: Node2D
@export var pile: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_player_hand_set_played(min_rank: int, max_rank: int, count: int) -> void:
	player_hand.remove_set(min_rank, max_rank, count)
	pile.play_run(min_rank, max_rank, count)
