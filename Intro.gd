extends Node2D

onready var sprite_animation = $Sprite/SpriteAniation

func _ready():
	sprite_animation.play("Idle")

func start_wave():
	sprite_animation.play("StartWave")

func wave():
	sprite_animation.play("Waving")

func _on_SpriteAniation_animation_finished(anim_name):
	if anim_name == "StartWave":
		wave()


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://levels/Level_001.tscn")
