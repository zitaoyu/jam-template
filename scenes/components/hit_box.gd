extends Area2D

class_name HitBox

signal dealt_damage_to(hurtbox: HurtBox)

@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
