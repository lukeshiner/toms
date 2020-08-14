extends Node2D

onready var tom = $Tom
onready var cleanup = $World/Cleanup

onready var message_2 = $Control/Message2
onready var message_3 = $Control/Message3
onready var message_4 = $Control/Message4
onready var message_5 = $Control/Message5
onready var timer = $Control/Timer
onready var message_sound = $MessageSound

func _on_Tom_scared():
	tom.can_freeze = true
	message_2.visible = true
	message_sound.play()

func _on_Tom_frozen():
	cleanup.enabled = true
	message_3.visible = true
	timer.start(5.0)
	message_sound.play()

func _on_Timer_timeout():
	message_4.visible = true
	message_sound.play()

func _on_Cleanup_start_cleanup():
	message_5.visible = true
	message_sound.play()
