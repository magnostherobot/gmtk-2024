extends Node2D

enum { PLAYER_TURN, OPPONENT_TURN, PERK_PICK }

@export var player_hand: Node2D
@export var pile: Node2D
@export var win_pile: Node2D

var state

func is_legal_move(min_rank: int, max_rank: int, count: int) -> bool:
	if count <= 0:
		return false
		
	return pile.is_beaten_by(min_rank, max_rank, count)
	
func make_opponent_move():
	var play_to_beat = pile.get_current_play()
	make_new_play(1, 1, 2)
	state = PLAYER_TURN

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = PLAYER_TURN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func make_new_play(min_rank: int, max_rank: int, count: int):
	var old_play = pile.get_current_play()
	win_pile.add_play(old_play[0], old_play[1], old_play[2])
	pile.play_run(min_rank, max_rank, count)

func _on_player_hand_set_played(min_rank: int, max_rank: int, count: int) -> void:
	if state != PLAYER_TURN:
		return
	
	if not is_legal_move(min_rank, max_rank, count):
		return
		
	player_hand.remove_set(min_rank, max_rank, count)
	make_new_play(min_rank, max_rank, count)
	state = OPPONENT_TURN
	$Timer.start(randf() + 1.0)

func _on_opponent_timer_timeout() -> void:
	make_opponent_move()
