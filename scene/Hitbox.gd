extends Area2D

@export var damage = 35

@onready var collision_shape_2d = $CollisionShape2D

func _init() -> void:
	collision_mask = 0
	collision_layer = 1

func set_disabled(is_disabled: bool) -> void:
	collision_shape_2d.set_deferred("disabled", is_disabled)
