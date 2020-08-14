extends Node


onready var progress = $ProgressLocation/CleanupProgress
onready var cleanup = $Cleanup
onready var timer = $CleanupTimer

var cleanup_time = 3.0
var hovered = false

var danger = null

func clean(object):
	danger = object
	cleanup.global_position = danger.global_position
	progress.get_parent().global_position = danger.global_position
	cleanup.visible = true
	progress.visible = true
	timer.start(cleanup_time)

func _process(_delta):
	if not timer.is_stopped():
		progress.value = lerp(
			progress.min_value, progress.max_value,
			inverse_lerp(cleanup_time, 0, timer.time_left)
		)


func _on_CleanupTimer_timeout():
	danger.queue_free()
	danger = null
	cleanup.visible = false
	progress.visible = false
