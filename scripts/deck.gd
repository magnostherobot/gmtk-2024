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
	
func reset():
	cards = [
		1, 1, 1, 1,
		2, 2, 2, 2,
		3, 3, 3, 3,
		4, 4, 4, 4,
		5, 5, 5, 5,
		6, 6, 6, 6,
		7, 7, 7, 7,
		8, 8, 8, 8,
	]
	cards.shuffle()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.visible = len(cards) > 0
	$Sprite2D.transform.origin.y = -len(cards) * 4
