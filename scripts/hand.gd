@tool
extends Node2D

@export var counts = [0, 0, 0, 0, 0, 0, 0, 0]

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
	print(selection_lowest, selection_highest)
	unselect_all()
	
func _on_mouse_exit() -> void:
	selecting = false
	unselect_all()

func _on_hand_input(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			_on_mouse_down()
		else:
			_on_mouse_up()
