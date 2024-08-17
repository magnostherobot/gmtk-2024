extends Node2D

var rank_piles: Array[Node2D]

var current_min_rank: int
var current_max_rank: int
var current_count: int

func is_beaten_by(min_rank: int, max_rank: int, count: int) -> bool:
	var current_rank_range = current_max_rank - current_min_rank + 1
	var rank_range = max_rank - min_rank + 1
	
	if count * rank_range > current_count * current_rank_range:
		return true
	elif count * rank_range < current_count * current_rank_range:
		return false
		
	if rank_range > current_rank_range:
		return true
	elif rank_range < current_rank_range:
		return false
		
	return max_rank > current_max_rank
	
func get_current_play() -> Array[int]:
	return [current_min_rank, current_max_rank, current_count]

func clear() -> void:
	current_min_rank = 0
	current_max_rank = 0
	current_count = 0
	for pile in rank_piles:
		pile.clear()

func play_cards(counts: Array) -> void:
	# does not set current play!
	clear()
	for i in range(0, len(counts)):
		rank_piles[i].play_cards(counts[i])

func play_run(min_rank: int, max_rank: int, count: int) -> void:
	clear()
	
	current_min_rank = min_rank
	current_max_rank = max_rank
	current_count = count
	
	for i in range(min_rank, max_rank + 1):
		rank_piles[i - 1].play_cards(count)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rank_piles = [
		$SingleRankPile1,
		$SingleRankPile2,
		$SingleRankPile3,
		$SingleRankPile4,
		$SingleRankPile5,
		$SingleRankPile6,
		$SingleRankPile7,
		$SingleRankPile8,
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
