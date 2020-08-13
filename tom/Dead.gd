extends State

var DeadSprite = preload("res://tom/DeadTom.tscn")

func enter_state(_previous_state):
	var instance = DeadSprite.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = parent.global_position
	parent.queue_free()
