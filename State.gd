extends Node
class_name State

onready var parent = get_parent().get_parent()
var can_focus = true

func state_logic(_delta):
	pass

func get_transition(_delta):
	return null

func enter_state(_previous_state):
	pass

func exit_state(_new_state):
	pass
