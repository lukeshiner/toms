extends State

func state_logic(_delta):
	pass

func get_transition(_delta):
	return null

func enter_state(_previous_state):
	parent.sprite.rotation_degrees = 0
	parent.animationPlayer.play("Idle")

func exit_state(_new_state):
	pass
