extends Node2D

var Enemy = preload("res://scene/enemy.tscn")
var Enemy2 = preload("res://scene/enemy_2.tscn")

func _ready():
	randomize()

func _on_enemy_spawn_timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	$Player/Path2D/PathFollow2D.h_offset = rng.randi_range(0, 3664)
	$Player/Path2D/PathFollow2D.v_offset = rng.randi_range(0, 3664)
	var instance = Enemy.instantiate()
	var instance2 = Enemy2.instantiate()

	instance.global_position = $Player/Path2D/PathFollow2D/Marker2D.global_position
	add_child(instance)
	add_child(instance2)
