@tool
extends Node2D

@export var counts = [0, 0, 0, 0, 0, 0, 0, 0]

func add_card(rank: int):
	counts[rank - 1] += 1

func add_cards(cards: Array):
	for card in cards:
		add_card(card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HandColumn.count = counts[0]
	$HandColumn2.count = counts[1]
	$HandColumn3.count = counts[2]
	$HandColumn4.count = counts[3]
	$HandColumn5.count = counts[4]
	$HandColumn6.count = counts[5]
	$HandColumn7.count = counts[6]
	$HandColumn8.count = counts[7]
