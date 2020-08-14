extends StaticBody2D


onready var highlight = $Highlight
var hovered = false

export(int) var damage = 25

func _ready():
	add_to_group("Dangers")
	add_to_group("Spikes")


func _on_MouseOver_mouse_entered():
	highlight.visible = true
	hovered = true


func _on_MouseOver_mouse_exited():
	highlight.visible = false
	hovered = false
