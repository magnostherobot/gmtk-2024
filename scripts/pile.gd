extends Node2D

var rank_piles: Array[Node2D]

func clear() -> void:
	for pile in rank_piles:
		pile.clear()

func play_cards(counts: Array) -> void:
	clear()
	for i in range(0, len(counts)):
		rank_piles[i].play_cards(counts[i])

func play_run(min_rank: int, max_rank: int, count: int) -> void:
	clear()
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
