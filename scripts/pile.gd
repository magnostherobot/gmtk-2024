extends Node2D

var rank_piles: Array[Node2D]

func play_cards(counts: Array) -> void:
	for i in range(0, len(counts)):
		rank_piles[i].play_cards(counts[i])

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
func _process(delta: float) -> void:
	pass
