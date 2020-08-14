extends Node2D

onready var label = $Label
onready var restart = $Restart
onready var next_level = $NextLevel
onready var menu = $Menu

func _ready():
	get_tree().paused = true

func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_NextLevel_pressed():
	pass # Replace with function body.


func _on_Menu_pressed():
	pass # Replace with function body.
