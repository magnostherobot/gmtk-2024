extends CPUParticles2D


func play_cards(rank: int, count: int) -> void:
	clear()
	self.amount = count
	self.lifetime = 1
	# TODO: update texture in use
	self.emitting = true
	self.speed_scale = 1
	$Timer.start()

func clear() -> void:
	self.restart()
	self.emitting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	self.speed_scale = 0
