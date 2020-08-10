extends Sprite

onready var timer = $Timer

var radius = 50
var time_to_live = 0.5

func _ready():
	var target_size = Vector2(radius * 2, radius * 2)
	var size = get_texture().get_size()
	scale = target_size / size
	timer.start(time_to_live)

func _process(_delta):
	var factor = inverse_lerp(time_to_live, 0, timer.time_left)
	scale *= lerp(1, 0, factor)


func _on_Timer_timeout():
	queue_free()
