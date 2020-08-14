extends Node2D



func _on_BackButton_pressed():
	get_tree().change_scene("res://ui/Menu.tscn")


func _on_GithubButton_pressed():
	OS.shell_open("http://github.com/lukeshiner/toms")
