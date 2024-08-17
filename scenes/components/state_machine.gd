extends Node
class_name StateMachine

@export var initial_state: State
@export var animated_sprite: AnimatedSprite2D
@export var character: CharacterBody2D

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transistion)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transistion(state, new_state_name):
	# only accept transition from curret state
	if state != current_state:
		return

	# check if new state is a valid state
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return

	# transition
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
	
	if animated_sprite:
		# animation name must match state name
		animated_sprite.play(new_state_name)
