extends Node2D

var Enemy = preload("res://scene/enemy.tscn")

func _ready():
	randomize()

func _on_enemy_spawn_timer_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	$Player/Path2D/PathFollow2D.offset = rng.randi_range(0, 3664)
	var instance = Enemy.instantiate()
	
	instance.global_position = $Player/Path2D/PathFollow2D/Marker2D.global_position
	add_child(instance)
	
