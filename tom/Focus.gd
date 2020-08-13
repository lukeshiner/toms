extends Control

var max_value = 100
var min_value = 0
export(float) var drain_time = 1.0
export(float) var recharge_time = 0.5

enum {
	UP, DOWN
}

var direction = DOWN

onready var focusBar = $FocusBar
onready var timer = $FocusTimer

signal focus_lost

func _ready():
	focusBar.max_value = max_value
	focusBar.min_value = min_value
	focusBar.value = max_value

func start():
	timer.start(drain_time)

func _physics_process(_delta):
	if not timer.is_stopped():
		var focus_value
		if direction == DOWN:
			focus_value = inverse_lerp(0, drain_time, timer.time_left)
		else:
			focus_value = inverse_lerp(recharge_time, 0, timer.time_left)
		focusBar.value = lerp(min_value, max_value, focus_value)

func is_focused():
	return direction == -1 and not timer.is_stopped()

func can_focus():
	return focusBar.value == max_value

func _on_FocusTimer_timeout():
	if direction == DOWN:
		direction = UP
		timer.start(recharge_time)
		emit_signal("focus_lost")
	else:
		direction = DOWN
		focusBar.value = max_value

