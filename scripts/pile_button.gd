extends Button

@export var win_pile: Node2D

func _on_pressed() -> void:
	win_pile.add_cards([10])
