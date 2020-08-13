extends KinematicBody2D

onready var sprite = $Sprite
onready var fireSprite = $Flaming
onready var stateMachine = $StateMachine
onready var animationPlayer = $AnimationPlayer
onready var focusTimer = $FocusTimer
onready var healthBar = $HealthBar
onready var focusBar = $FocusBar

onready var WANDER = $StateMachine/Wander
onready var FREEZE = $StateMachine/Freeze
onready var RUN_FROM = $StateMachine/RunFrom
onready var BURN = $StateMachine/Burn

export(float) var focus_time = 1.0

var health = 100.0 setget health_set

func health_set(value):
	healthBar.set_health(health)
	health = value

func _ready():
	randomize()
	stateMachine.set_state(BURN)

func _physics_process(_delta):
	var focus_value = inverse_lerp(0, focus_time, focusTimer.time_left)
	focusBar.value = lerp(0, 100, focus_value)

func run_from(location):
	stateMachine.set_state(RUN_FROM)
	var to_mouse = position.direction_to(location)
	var direction = to_mouse * -1
	focusTimer.start(focus_time)
	stateMachine.state.direction = direction

func freeze():
	focusTimer.start(focus_time)
	stateMachine.set_state(FREEZE)

func _on_FocusTimer_timeout():
	stateMachine.set_state(WANDER)
