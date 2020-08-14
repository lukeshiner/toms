extends StaticBody2D


onready var highlight = $Highlight
var hovered = false


func _on_Area2D_mouse_entered():
	highlight.visible = true
	hovered = true


func _on_Area2D_mouse_exited():
	highlight.visible = false
	hovered = false
