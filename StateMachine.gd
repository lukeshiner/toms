extends Node
class_name StateMachine


var state = null
var previous_state = null
onready var states = get_children()

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		state.state_logic(delta)
		var transition = state.get_transition(delta)
		if transition != null:
			set_state(transition)

func set_state(new_state):
	previous_state = state
	state = new_state
	if previous_state != null:
		previous_state.exit_state(new_state)
	if new_state != null:
		state.enter_state(previous_state)
