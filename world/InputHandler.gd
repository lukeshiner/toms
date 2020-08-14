extends Node

var ClickIndicator = preload("res://tom/ClickIndicator.tscn")
var EndLevel = preload("res://ui/EndLevel.tscn")
export(float) var focus_distance = 80

onready var cleanup = get_parent().get_node("Cleanup")

var toms = []
var dangers = []

func click_indicator(location):
	var instance = ClickIndicator.instance()
	instance.position = location
	get_tree().current_scene.add_child(instance)

func _process(_delta):
	toms = get_tree().get_nodes_in_group("Toms")
	dangers = get_tree().get_nodes_in_group("Dangers")
	if len(toms) == 0 or len(dangers) == 0:
		var instance = EndLevel.instance()
		get_tree().current_scene.add_child(instance)
		if len(toms) == 0:
			instance.label.text = "All the Toms died"
			instance.next_level.disabled = true
			instance.lose_sound.play()
		else:
			instance.label.text = "You Saved " + str(len(toms)) + " Tom"
			if len(toms) > 1:
				instance.label.text += "s!"
			else:
				instance.label.text += "!"
			instance.next_level.disabled = false
			instance.win_sound.play()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
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
