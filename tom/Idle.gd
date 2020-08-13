extends State

func enter_state(_previous_state):
	parent.sprite.rotation_degrees = 0
	parent.animationPlayer.play("Idle")
