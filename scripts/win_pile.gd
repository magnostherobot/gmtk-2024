extends Node2D

var contents = [0, 0, 0, 0, 0, 0, 0, 0]
var cards_displayed = 0
var animating = false

func total_card_count():
	var result = 0
	for count in contents:
		result += count
	return result
	
func start_animating():
	animating = true
	$CPUParticles2D.speed_scale = 8

func stop_animating():
	animating = false
	$CPUParticles2D.speed_scale = 0

func check_card_count():
	if cards_displayed >= total_card_count():
		stop_animating()
	elif cards_displayed < total_card_count():
		start_animating()
		
func add_cards(counts: Array):
	for i in range(0, len(counts)):
		contents[i] += counts[i]
	check_card_count()
	
func add_play(min_rank: int, max_rank: int, count: int):
	for i in range(min_rank, max_rank + 1):
		contents[i - 1] += count
	check_card_count()
	
func empty():
	var result = contents
	contents = [0, 0, 0, 0, 0, 0, 0, 0]
	$CPUParticles2D.restart()
	stop_animating()
	return result

func _on_timer_timeout() -> void:
	if animating:
		cards_displayed += 1
		check_card_count()
