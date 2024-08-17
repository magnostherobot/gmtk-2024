extends CPUParticles2D


func play_cards(rank: int, count: int) -> void:
	self.amount = count
	# TODO: update texture in use
	self.emitting = true
	self.speed_scale = 1
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_cards(1, 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	self.speed_scale = 0
