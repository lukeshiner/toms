extends Move

onready var stop_burn_timer = $BurnTimer

var damage_timer = Timer.new()
var damage = 12

func _ready():
	can_focus = false
	speed = 8192
	wobble_step = 17
	wobble_extent = 9

	damage_timer.one_shot = false

	damage_timer.wait_time = 1.0
	add_child(damage_timer)

	damage_timer.connect("timeout", self, "_on_damage_timer_timeout")

func _on_damage_timer_timeout():
	parent.health -= damage / 2

func state_logic(delta):
	.state_logic(delta)
	var collided = parent.get_slide_count()
	if collided or rand_range(0, 1) < 0.02:
		direction = get_direction()

func get_transition(_delta):
	if parent.health <= 0:
		return parent.BURNED
	elif stop_burn_timer.is_stopped():
		return parent.WANDER
	return null

func enter_state(_previous_state):
	parent.animationPlayer.play("Scared")
	parent.fireSprite.visible = true
	parent.health -= damage
	direction = get_direction()
	damage_timer.start()
	stop_burn_timer.start((float(randi() % 20) + 10.0) / 10)
	parent.burn_sound.play()

func exit_state(_new_state):
	damage_timer.stop()
	stop_burn_timer.stop()
	parent.fireSprite.visible = false

func get_direction():
	return Vector2.UP.rotated(deg2rad(randi() % 360))
