extends Move

func _ready():
	speed = 6720
	wobble_step = 17
	wobble_extent = 9

func get_transition(_delta):
	return null

func enter_state(_previous_state):
	parent.animationPlayer.play("Run")

func exit_state(_new_state):
	pass
