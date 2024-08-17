extends Node

class_name Health


signal health_changed(diff: int)
signal max_health_changed(diff: int)
signal health_depleted

@export var max_health: int = 1 : set = set_max_health, get = get_max_health
@export var health: int = 1 : set = set_health, get = get_health
@export var invinvible_time: float = 0.5
var is_invincible: bool = false : set = set_is_invincible, get = get_is_invincible
var invincible_timer: Timer = null


func set_health(new_health: int):
	if new_health != health:
		new_health = clampi(new_health, 0, max_health)
		var diff: int = new_health - health
		health = new_health
		health_changed.emit(diff)
		
		if health == 0:
			health_depleted.emit()

func get_health() -> int:
	return health

func set_max_health(new_max_health: int):
	if new_max_health > 0 or new_max_health != max_health:
		var diff = new_max_health - max_health
		max_health = new_max_health
		max_health_changed.emit(diff)
		
		if max_health < health:
			set_health(max_health)

func get_max_health() -> int:
	return max_health
	
func set_is_invincible(value: bool):
	is_invincible = value
	
func get_is_invincible() -> bool:
	return is_invincible

# Start invincible timer
func start_temporary_invincible():
	if invincible_timer == null:
		invincible_timer = Timer.new()
		invincible_timer.one_shot = true
		add_child(invincible_timer)
		
	if invincible_timer.timeout.is_connected(set_is_invincible):
		invincible_timer.timeout.disconnect(set_is_invincible)
		
	invincible_timer.set_wait_time(invinvible_time)
	invincible_timer.timeout.connect(set_is_invincible.bind(false))
	is_invincible = true
	invincible_timer.start()
