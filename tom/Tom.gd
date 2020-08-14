extends KinematicBody2D

onready var sprite = $Sprite
onready var fireSprite = $Flaming
onready var stateMachine = $StateMachine
onready var animationPlayer = $AnimationPlayer
onready var healthBar = $HealthBar
onready var focus = $Focus

onready var WANDER = $StateMachine/Wander
onready var FREEZE = $StateMachine/Freeze
onready var RUN_FROM = $StateMachine/RunFrom
onready var BURN = $StateMachine/Burn
onready var BURNED = $StateMachine/Burned
onready var DEAD = $StateMachine/Dead

onready var burn_sound = $BurnSound
onready var spikes_sound = $SpikesSound

var health = 100.0 setget health_set

signal scared
signal frozen

export(bool) var can_freeze = true
export(bool) var can_scare = true

func health_set(value):
	healthBar.set_health(health)
	health = value

func _ready():
	randomize()
	stateMachine.set_state(WANDER)
	add_to_group("Toms")

func run_from(location):
	if stateMachine.state.can_focus and focus.can_focus() and can_scare:
		stateMachine.set_state(RUN_FROM)
		var to_mouse = position.direction_to(location)
		var direction = to_mouse * -1
		focus.start()
		stateMachine.state.direction = direction
		emit_signal("scared")

func freeze():
	if stateMachine.state.can_focus and focus.can_focus() and can_freeze:
		focus.start()
		stateMachine.set_state(FREEZE)
		emit_signal("frozen")

func _on_Focus_focus_lost():
	if stateMachine.state in [RUN_FROM, FREEZE]:
		stateMachine.set_state(WANDER)
