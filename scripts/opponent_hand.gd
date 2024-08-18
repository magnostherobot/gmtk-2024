@tool
extends Node2D

@export var counts: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0]

func get_total_count() -> int:
	var result := 0
	for count in counts:
		result += count
	return result

func add_card(rank: int):
	if rank > 0:
		counts[rank - 1] += 1
		
func add_card_counts(new_counts: Array[int]):
	for i in range(0, len(new_counts)):
		counts[i] += new_counts[i]

func remove_set(min_rank: int, max_rank: int, count: int):
	for i in range(min_rank, max_rank + 1):
		counts[i - 1] -= count
		
func clear() -> Array[int]:
	var result = counts
	counts = [0, 0, 0, 0, 0, 0, 0, 0]
	return result

func get_size() -> int:
	var result = 0
	for i in range(0, len(counts)):
		result += counts[i]
	return result
	
func is_empty() -> bool:
	return get_size() == 0

func _process(_delta: float):
	$HandColumn.count = get_total_count()
