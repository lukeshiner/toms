extends Move

func _ready():
	speed = 3200

func state_logic(delta):
	.state_logic(delta)
	var collided = parent.get_slide_count()
	if collided or rand_range(0, 1) < 0.01:
		direction = get_direction()
	if velocity != Vector2.ZERO:
		parent.animationPlayer.play("Run")
	else:
		parent.animationPlayer.play("Idle")

func enter_state(_previous_state):
	parent.animationPlayer.play("Idle")
	direction = get_direction()

func exit_state(_new_state):
	pass
