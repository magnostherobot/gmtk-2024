extends Button

@export var pile: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	var thrown = []
	for i in range(0, 8):
		thrown.push_back(randi() % 100 + 1)
	pile.play_cards(thrown)
