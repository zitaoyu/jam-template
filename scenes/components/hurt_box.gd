extends Area2D

class_name HurtBox

signal received_damage(damage: int)

@export var health : Health

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null and not health.is_invincible:
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		# hitbox emit a signal to notify that it dealt damage to object
		hitbox.dealt_damage_to.emit(self)
