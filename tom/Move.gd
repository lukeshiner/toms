extends State
class_name Move

var direction = Vector2.ZERO
var wobble_time = 0
var wobble_step = 15
var wobble_extent = 7
var speed = 0
var velocity = Vector2.ZERO

func state_logic(delta):
	velocity = direction * speed
	parent.move_and_slide_with_snap(velocity * delta, Vector2(16, 16))

	if velocity.x < 0:
		parent.sprite.flip_h = true
	else:
		parent.sprite.flip_h = false
	if velocity != Vector2.ZERO:
		parent.sprite.rotation_degrees = lerp(-wobble_extent, wobble_extent, sin(wobble_time))
		wobble_time += wobble_step * delta
	else:
		parent.sprite.rotation_degrees = 0
	.state_logic(delta)

func get_transition(_delta):
	return null

func enter_state(_previous_state):
	parent.animationPlayer.play("Run")

func exit_state(_new_state):
	pass

func get_direction():
	var directions = [
		Vector2.UP, Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.ZERO
	]
	var index = randi() % directions.size()
	return directions[index]
