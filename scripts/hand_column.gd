@tool
extends Node2D

@export var count: int = 0
@export var rank: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Label.text = str(count)
	$Card.rank = rank
	
	self.visible = count > 0
	$Label.visible = count != 1
