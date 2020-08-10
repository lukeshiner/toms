extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

export(Color) var healthy_colour = Color.green
export(Color) var warning_colour = Color.yellow
export(Color) var danger_colour = Color.red

export(float, 0, 1, 0.05) var warning_zone = 0.5
export(float, 0, 1, 0.05) var danger_zone = 0.2

func set_health(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, health, 0.4, Tween.TRANS_SINE)
	update_tween.start()
	health_under.value = health
	set_colour()

func set_colour():
	if health_over.value < health_over.max_value * danger_zone:
		health_over.tint_progress = danger_colour
	elif health_over.value < health_over.max_value * warning_zone:
		health_over.tint_progress = warning_colour
	else:
		health_over.tint_progress = healthy_colour
