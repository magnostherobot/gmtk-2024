@tool
extends Node2D

# last card in array is top of deck
@export var cards: Array[int] = []

func draw_card() -> int:
	if len(cards) > 0:
		return cards.pop_back()
	else:
		return 0

func add_cards(new_cards: Array[int]):
	cards = new_cards + cards
	
func add_card_counts(new_counts: Array[int]):
	var result: Array[int] = []
	for i in range(0, len(new_counts)):
		for j in range(0, new_counts[i]):
			result.push_back(i + 1)
	result.shuffle()
	add_cards(result)
	
func reset(n: int):
	cards = []
	for i in range(0, n):
		for r in range(1, 9):
			cards.push_back(r)
	cards.shuffle()
	
func get_size() -> int:
	return len(cards)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.visible = len(cards) > 0
	$Sprite2D.transform.origin.y = -len(cards) * 4
