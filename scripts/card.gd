@tool
extends Node2D

@export var rank: int = 1
@export var faceup: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if faceup:
		$Sprite2D.frame = rank - 1
	else:
		$Sprite2D.frame = 8
