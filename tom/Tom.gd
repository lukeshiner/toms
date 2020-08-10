extends KinematicBody2D

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var focusTimer = $FocusTimer
onready var healthBar = $HealthBar
onready var focusBar = $FocusBar

var velocity = Vector2.ZERO
var direction = Vector2.UP

var wobble_time = 0
var wobble_step = 15
var wobble_extent = 7

export(int) var walk_speed = 3200
export(int) var run_speed = 6720
export(float) var focus_time = 1.0
var speed = walk_speed
var random_direction = true

var health = 100.0 setget health_set

func health_set(value):
	healthBar.set_health(health)
	health = value

func _ready():
	direction = get_direction()
	animationPlayer.play("Idle")

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide_with_snap(velocity * delta, Vector2(16, 16))
	var collided = get_slide_count()
	if random_direction:
		if collided or rand_range(0, 1) < 0.01:
			direction = get_direction()
	if velocity != Vector2.ZERO:
		sprite.rotation_degrees = lerp(-wobble_extent, wobble_extent, sin(wobble_time))
		wobble_time += wobble_step * delta
	else:
		sprite.rotation_degrees = 0
	var focus_value = inverse_lerp(0, focus_time, focusTimer.time_left)
	focusBar.value = lerp(0, 100, focus_value)
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func get_direction():
	var directions = [
		Vector2.UP, Vector2.LEFT, Vector2.RIGHT, Vector2.DOWN, Vector2.ZERO
	]
	var index = randi() % directions.size()
	return directions[index]

func run_from(location):
	var to_mouse = position.direction_to(location)
	direction = to_mouse * -1
	speed = run_speed
	random_direction = false
	focusTimer.start(focus_time)

func freeze():
	direction = Vector2.ZERO
	random_direction = false
	focusTimer.start(focus_time)

func _on_FocusTimer_timeout():
	speed = walk_speed
	random_direction = true
