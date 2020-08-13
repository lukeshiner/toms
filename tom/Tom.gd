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

var health = 100.0 setget health_set

func health_set(value):
	healthBar.set_health(health)
	health = value

func _ready():
	randomize()
	stateMachine.set_state(WANDER)

func run_from(location):
	if stateMachine.state.can_focus and focus.can_focus():
		stateMachine.set_state(RUN_FROM)
		var to_mouse = position.direction_to(location)
		var direction = to_mouse * -1
		focus.start()
		stateMachine.state.direction = direction

func freeze():
	if stateMachine.state.can_focus and focus.can_focus():
		focus.start()
		stateMachine.set_state(FREEZE)

func _on_Focus_focus_lost():
	stateMachine.set_state(WANDER)
