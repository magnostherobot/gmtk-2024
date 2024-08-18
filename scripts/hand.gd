@tool
extends Node2D

signal set_played(min: int, max: int, count: int)

@export var counts: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0]

var cards_hovered = [false, false, false, false, false, false, false, false]
var last_hovered: int
var columns: Array = []

var selecting = false
var selection_lowest: int
var selection_highest: int

func add_card(rank: int):
	if rank > 0:
		counts[rank - 1] += 1

func add_cards(cards: Array):
	for card in cards:
		add_card(card)
		
func remove_set(min_rank: int, max_rank: int, count: int) -> void:
	for i in range(min_rank, max_rank + 1):
		counts[i - 1] -= count

func remove_cards(removed_counts: Array[int]) -> Array[int]:
	var result = []
	for i in range(0, len(removed_counts)):
		var to_remove = min(self.counts[i], removed_counts[i])
		self.counts[i] -= to_remove
		result.push_back(to_remove)
	return result
	
func clear() -> Array[int]:
	var result := counts
	counts = [0, 0, 0, 0, 0, 0, 0, 0]
	return result

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
		
func unselect_all() -> void:
	for col in columns:
		col.unselect()
	
func update_selection(rank: int) -> void:
	if rank != last_hovered:
		if selecting:
			
			if rank == 0:
				unselect_all()
				selection_lowest = 0
				selection_highest = 0
				
			elif selection_lowest == selection_highest:
				if rank < selection_lowest:
					selection_lowest = rank
				if rank > selection_highest:
					selection_highest = rank
				select(rank)
				
			elif last_hovered == selection_lowest:
				if rank < selection_lowest:
					selection_lowest = rank
					select(rank)
				elif rank > selection_lowest:
					unselect(selection_lowest)
					selection_lowest = rank
					
			elif last_hovered == selection_highest:
				if rank > selection_highest:
					selection_highest = rank
					select(rank)
				elif rank < selection_highest:
					unselect(selection_highest)
					selection_highest = rank
					
		else:
			unselect(last_hovered)
			select(rank)
		
		last_hovered = rank
		
func suggest_set(min_rank: int, max_rank: int) -> void:
	var count = counts[max_rank - 1]
	for i in range(min_rank, max_rank):
		count = min(count, counts[i - 1])
	print("suggesting set ", count, "x", min_rank, "->", max_rank)
	set_played.emit(min_rank, max_rank, count)

func _on_card_hovered(rank: int) -> void:
	cards_hovered[rank - 1] = true
	update_selection(calculate_highest_hovered())
	
func _on_card_unhovered(rank: int) -> void:
	cards_hovered[rank - 1] = false
	update_selection(calculate_highest_hovered())
	
func _on_mouse_down():
	selecting = true
	selection_highest = last_hovered
	selection_lowest = last_hovered
	
func _on_mouse_up():
	selecting = false
	suggest_set(selection_lowest, selection_highest)
	unselect_all()
	
func _on_mouse_exit() -> void:
	selecting = false
	unselect_all()

func _on_hand_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			_on_mouse_down()
		else:
			_on_mouse_up()
