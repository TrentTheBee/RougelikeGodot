extends Area2D

@export var damage = 35

@onready var collision_shape_2d = $CollisionShape2D

func _init(is_disabled: bool) -> void:
	collision_shape_2d.set_deferred("disabled", is_disabled)
