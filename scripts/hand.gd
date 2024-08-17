@tool
extends Node2D

@export var counts = [0, 0, 0, 0, 0, 0, 0, 0]

var cards_hovered = [false, false, false, false, false, false, false, false]
var last_hovered: int
var columns: Array = []

func add_card(rank: int):
	if rank > 0:
		counts[rank - 1] += 1

func add_cards(cards: Array):
	for card in cards:
		add_card(card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = [
		$HandColumn1,
		$HandColumn2,
		$HandColumn3,
		$HandColumn4,
		$HandColumn5,
		$HandColumn6,
		$HandColumn7,
		$HandColumn8,
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for i in range(0, len(columns)):
		columns[i].count = counts[i]

func calculate_highest_hovered() -> int:
	for i in range(len(cards_hovered), 0, -1):
		if (cards_hovered[i - 1]):
			return i
	return 0
	
func select(rank: int) -> void:
	if rank != 0:
		columns[rank - 1].select()
		
func unselect(rank: int) -> void:
	if rank != 0:
		columns[rank - 1].unselect()
	
func update_selection(rank: int) -> void:
	if rank != last_hovered:
		unselect(last_hovered)
		select(rank)
	last_hovered = rank

func _on_card_hovered(rank: int) -> void:
	cards_hovered[rank - 1] = true
	update_selection(calculate_highest_hovered())
	
func _on_card_unhovered(rank: int) -> void:
	cards_hovered[rank - 1] = false
	update_selection(calculate_highest_hovered())
