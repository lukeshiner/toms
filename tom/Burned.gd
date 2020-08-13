extends State

var BurnedSprite = preload("res://tom/BurnedTom.tscn")

func enter_state(_previous_state):
	var instance = BurnedSprite.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = parent.global_position
	parent.queue_free()
