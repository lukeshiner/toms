extends Move

var damage_timer = Timer.new()
var stop_burn_timer = Timer.new()
var damage = 15

func _ready():
	can_focus = false
	speed = 8192
	wobble_step = 17
	wobble_extent = 9

	damage_timer.one_shot = false

	damage_timer.wait_time = 1.0
	add_child(damage_timer)

	stop_burn_timer.one_shot = true
	stop_burn_timer.wait_time = (float(randi() % 30) + 20) / 10
	self.add_child(stop_burn_timer)

	damage_timer.connect("timeout", self, "_on_damage_timer_timeout")

func _on_damage_timer_timeout():
	parent.health -= damage

func state_logic(delta):
	.state_logic(delta)
	var collided = parent.get_slide_count()
	if collided or rand_range(0, 1) < 0.02:
		direction = get_direction()

func get_transition(_delta):
	if stop_burn_timer.is_stopped():
		return parent.WANDER
	return null

func enter_state(_previous_state):
	parent.animationPlayer.play("Scared")
	parent.fireSprite.visible = true
	direction = get_direction()
	damage_timer.start()
	stop_burn_timer.start()

func exit_state(_new_state):
	damage_timer.stop()
	stop_burn_timer.stop()
	parent.fireSprite.visible = false

func get_direction():
	return Vector2.UP.rotated(deg2rad(randi() % 360))
