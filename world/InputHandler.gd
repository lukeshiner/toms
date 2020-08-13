extends Node

var ClickIndicator = preload("res://tom/ClickIndicator.tscn")
export(float) var focus_distance = 80

func click_indicator(location):
	var instance = ClickIndicator.instance()
	instance.position = location
	get_tree().current_scene.add_child(instance)


func _input(event):
	var toms = get_tree().current_scene.get_node("Toms").get_children()
	if event is InputEventMouseButton and event.pressed:
		click_indicator(event.position)
		for tom in toms:
			if tom.position.distance_to(event.position) <= focus_distance:
				if event.button_index == BUTTON_LEFT:
					tom.run_from(event.position)
				elif event.button_index == BUTTON_RIGHT:
					tom.freeze()
