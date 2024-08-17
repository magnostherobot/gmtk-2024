@tool
extends Node2D

# last card in array is top of deck
@export var cards: Array[int] = []

func draw_card() -> int:
	if len(cards) > 0:
		return cards.pop_back()
	else:
		return 0

func add_cards(new_cards: Array):
	cards = new_cards + cards

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.visible = len(cards) > 0
	$Sprite2D.transform.origin.y = -len(cards) * 4
