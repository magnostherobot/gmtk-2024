@tool
extends Node2D

signal card_hovered(rank: int)
signal card_unhovered(rank: int)

@export var count: int = 0
@export var rank: int = 1
@export var faceup: bool = true

var selected = false

func select() -> void:
	if not selected:
		$Visual.translate(Vector2(0, -20))
		selected = true
	
func unselect() -> void:
	if selected:
		$Visual.translate(Vector2(0, 20))
		selected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Visual/Label.text = str(count)
	$Visual/Card.rank = rank
	$Visual/Card.faceup = faceup
	
	self.visible = count > 0
	$Visual/Label.visible = count != 1

func _on_area_2d_mouse_entered() -> void:
	card_hovered.emit(rank)

func _on_area_2d_mouse_exited() -> void:
	card_unhovered.emit(rank)
