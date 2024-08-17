extends Node2D

enum { PLAYER_TURN, OPPONENT_TURN, PERK_PICK }

@export var player_hand: Node2D
@export var player_deck: Node2D
@export var opponent_deck: Node2D
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
	
func move_play_to_pile():
	var old_play = pile.get_current_play()
	win_pile.add_play(old_play[0], old_play[1], old_play[2])
	pile.clear()

func make_new_play(min_rank: int, max_rank: int, count: int):
	move_play_to_pile()
	pile.play_run(min_rank, max_rank, count)
	
func give_pile(deck: Node2D):
	var winnings = win_pile.empty()
	# winnings is an occurence array
	
	var cards: Array[int] = []
	for i in range(0, len(winnings)):
		for j in range(0, winnings[i]):
			cards.push_back(i + 1)
	
	cards.shuffle()
	deck.add_cards(cards)

func give_player_pile():
	give_pile(player_deck)
	
func give_opponent_pile():
	give_pile(opponent_deck)

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

func _on_player_pass() -> void:
	move_play_to_pile()
	give_opponent_pile()
	
