extends CPUParticles2D

@export var card_texture: Texture

func play_cards(count: int) -> void:
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
func _process(_delta: float) -> void:
	self.texture = card_texture


func _on_timer_timeout() -> void:
	self.speed_scale = 0
