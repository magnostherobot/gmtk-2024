extends Button

@export var deck: Node2D
@export var hand: Node2D

func _button_pressed():
	var drawn = deck.draw_card()
	hand.add_card(drawn)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
