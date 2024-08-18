extends Node2D

enum { PLAYER_TURN, OPPONENT_TURN, GAME_OVER }

@export var play_scale := 1
@export var player_hand: Node2D
@export var opponent_hand: Node2D
@export var player_deck: Node2D
@export var opponent_deck: Node2D
@export var pile: Node2D
@export var win_pile: Node2D

const play_ranges: Array[Array] = [
	[1,8],
	[2,8], [1,7],
	[3,8], [2,7], [1,6],
	[4,8], [3,7], [2,6], [1,5],
	[5,8], [4,7], [3,6], [2,5], [1,4],
	[6,8], [5,7], [4,6], [3,5], [2,4], [1,3],
	[7,8], [6,7], [5,6], [4,5], [3,4], [2,3], [1,2],
	[8,8], [7,7], [6,6], [5,5], [4,4], [3,3], [2,2], [1,1],
]

var state

func is_legal_move(min_rank: int, max_rank: int, count: int) -> bool:
	if count <= 0:
		return false
		
	return pile.is_beaten_by(min_rank, max_rank, count)
	
func calculate_run_count(counts: Array[int], min_rank: int, max_rank: int) -> int:
	var min_count = counts[max_rank - 1]
	for i in range(min_rank, max_rank):
		min_count = min(counts[i - 1], min_count)
	return min_count
	
func weakest_legal_move(counts: Array[int], to_beat: Array[int]) -> Array:
	var legal_play_found = false
	
	var weakest_play: Array[int]
	var weakest_play_card_count = 1000000
	
	for i in range(len(play_ranges) - 1, -1, -1):
		var play = play_ranges[i]
		var count = calculate_run_count(counts, play[0], play[1])
		var total_count = count * (play[1] - play[0] + 1)
		if is_legal_move(play[0], play[1], count) and total_count < weakest_play_card_count:
			legal_play_found = true
			weakest_play = [play[0], play[1], count]
			weakest_play_card_count = total_count
			
	return [legal_play_found, weakest_play]

func give_player_opponents_hand():
	player_deck.add_card_counts(opponent_hand.clear())

func give_opponent_players_hand():
	opponent_deck.add_card_counts(player_hand.clear())
	
func player_wins_hand():
	print("player wins hand")
	move_play_to_pile()
	give_player_pile()
	give_player_opponents_hand()
	start_hand(PLAYER_TURN)

func opponent_wins_hand():
	print("opponent wins hand")
	move_play_to_pile()
	give_opponent_pile()
	give_opponent_players_hand()
	start_hand(OPPONENT_TURN)

func make_opponent_move():
	var play_to_beat = pile.get_current_play()
	var my_play = weakest_legal_move(opponent_hand.counts, play_to_beat)
	
	if not my_play[0]:
		opponent_pass()
	else:
		print("opponent plays ", my_play[1][2], "x", my_play[1][0], "->", my_play[1][1])
		opponent_hand.remove_set(my_play[1][0], my_play[1][1], my_play[1][2])
		make_new_play(my_play[1][0], my_play[1][1], my_play[1][2])
		
		if opponent_hand.is_empty():
			$WinHandTimer.start(2)
		else:
			start_player_turn()
	
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
	
func draw_cards(deck: Node2D, hand: Node2D, count: int):
	for i in range(0, count):
		hand.add_card(deck.draw_card())

func draw_player_cards(count: int):
	draw_cards(player_deck, player_hand, count)

func draw_opponent_cards(count: int):
	draw_cards(opponent_deck, opponent_hand, count)
	
func draw_both_cards(count: int):
	draw_player_cards(count)
	draw_opponent_cards(count)
	
func draw_player_cards_or_lose(count: int):
	pass
	
func start_player_turn():
	state = PLAYER_TURN
	
func start_opponent_turn():
	state = OPPONENT_TURN
	$Timer.start(randf() + 1.0)
	
func player_pass():
	print("player passes")
	move_play_to_pile()
	give_opponent_pile()
	start_opponent_turn()
	draw_player_cards(2 * play_scale)
	
func opponent_pass():
	print("opponent passes")
	move_play_to_pile()
	give_player_pile()
	start_player_turn()
	draw_opponent_cards(2 * play_scale)
	
func win():
	print("player wins")
	play_scale *= 2
	start_game()
	
func lose():
	print("opponent wins")
	state = GAME_OVER
	
func start_hand(lead):
	print("new hand started")
	
	if player_deck.get_size() < 10:
		lose()
	elif opponent_deck.get_size() < 10:
		win()
	else:
		draw_both_cards(10 * play_scale)
		
		if lead == PLAYER_TURN:
			start_player_turn()
		else:
			start_opponent_turn()
	
func start_game():
	print("game started")
	player_deck.reset(2 * play_scale)
	opponent_deck.reset(2 * play_scale)
	player_hand.clear()
	opponent_hand.clear()
	start_hand(PLAYER_TURN)
	start_player_turn()

func _ready() -> void:
	start_game()

func _on_player_hand_set_played(min_rank: int, max_rank: int, count: int) -> void:
	if state != PLAYER_TURN:
		return
	
	if not is_legal_move(min_rank, max_rank, count):
		return
		
	print("player plays ", count, "x", min_rank, "->", max_rank)
	player_hand.remove_set(min_rank, max_rank, count)
	make_new_play(min_rank, max_rank, count)
	
	if player_hand.is_empty():
		$WinHandTimer.start(2)
	else:
		start_opponent_turn()

func _on_opponent_timer_timeout() -> void:
	make_opponent_move()

func _on_player_pass() -> void:
	player_pass()

func _on_win_hand_timer_timeout() -> void:
	if state == OPPONENT_TURN:
		opponent_wins_hand()
	elif state == PLAYER_TURN:
		player_wins_hand()
