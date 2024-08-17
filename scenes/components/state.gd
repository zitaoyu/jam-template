extends Node

# Use this as an interface for State
class_name State

signal transitioned

@export var state_machine: StateMachine
@export var character: CharacterBody2D

func _ready():
	state_machine = get_parent()
	character = state_machine.character

# Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

# Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass

# Called by the state machine upon changing the active state.
func enter() -> void:
	pass

# Called by the state machine before changing the active state. Use this function to clean up state.
func exit() -> void:
	pass
