extends Node2D

onready var label = $Label
onready var restart = $Restart
onready var next_level = $NextLevel
onready var menu = $Menu
onready var win_sound = $WinSound
onready var lose_sound = $LoseSound

func _ready():
	get_tree().paused = true

func _on_Restart_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_NextLevel_pressed():
	var next_level_path = "res://levels/Level_00" + str(int(get_tree().current_scene.name) + 1) + ".tscn"
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_level_path)
	get_tree().paused = false


func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/Menu.tscn")
	get_tree().paused = false
