extends Node
class_name State

onready var parent = get_parent().get_parent()
var can_focus = true

func state_logic(_delta):
	handle_collision()

func get_transition(_delta):
	if parent.health <= 0:
		return parent.DEAD
	return null

func enter_state(_previous_state):
	pass

func exit_state(_new_state):
	pass

func handle_collision():
	for i in range(parent.get_slide_count()):
		var collision = parent.get_slide_collision(i)
		if collision.collider.is_in_group("Toms"):
			collide_tom(collision)
		elif collision.collider.is_in_group("Fire"):
			collide_fire(collision)
		elif collision.collider.is_in_group("Spikes"):
			collide_spikes(collision)

func collide_tom(collision):
	var tom = collision.collider
	if tom.stateMachine.state == tom.BURN:
		parent.stateMachine.set_state(parent.BURN)

func collide_fire(_collision):
	parent.stateMachine.set_state(parent.BURN)

func collide_spikes(collision):
	parent.health -= collision.collider.damage
	parent.stateMachine.state = parent.RUN_FROM
	parent.stateMachine.state.direction = parent.global_position.direction_to(collision.collider.global_position) * -1
	parent.spikes_sound.play()
