extends Node2D



func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://levels/Level_001.tscn")


func _on_AboutButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/About.tscn")

