extends State

var initial_force = false
var jump_ended = false

func enter():
	character.velocity.y = Player.INITIAL_JUMP_FORCE

func exit():
	jump_ended = false

func physics_update(_delta: float) -> void:
	if !jump_ended && Input.is_action_pressed("jump"):
		character.velocity.y = max(character.velocity.y + Player.JUMP_FORCE_ACCELERATION * _delta, 
								Player.MAX_JUMP_FORCE)
		if character.velocity.y == Player.MAX_JUMP_FORCE:
			jump_ended = true
	else:
		jump_ended = true

	var direction = Input.get_axis("left", "right")

	if direction:
		character.velocity.x = direction * Player.MAX_SPEED
	
	if character.velocity.y > 0:
		transitioned.emit(self, "falling")
