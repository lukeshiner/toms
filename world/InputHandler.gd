extends Node

var ClickIndicator = preload("res://tom/ClickIndicator.tscn")
export(float) var focus_distance = 80

onready var cleanup = get_tree().current_scene.get_node("Cleanup")

func click_indicator(location):
	var instance = ClickIndicator.instance()
	instance.position = location
	get_tree().current_scene.add_child(instance)


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var toms = get_tree().current_scene.get_node("Toms").get_children()
		var dangers = get_tree().current_scene.get_node("Dangers").get_node("Fires").get_children()
		for danger in dangers:
			if danger.hovered:
				cleanup.clean(danger)
				return
		click_indicator(event.position)
		for tom in toms:
			if tom.position.distance_to(event.position) <= focus_distance:
				if event.button_index == BUTTON_LEFT:
					tom.run_from(event.position)
				elif event.button_index == BUTTON_RIGHT:
					tom.freeze()
