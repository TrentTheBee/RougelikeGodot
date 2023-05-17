extends Node2D

@onready var marker_2d = $"Pixilart-drawing(1)/Marker2D"



var bullet_scene = preload("res://scene/bullet.tscn")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("projectile"):
		fire()


func fire():
	var bullet = bullet_scene.instantiate()
	print(bullet.direction)
	bullet.direction = marker_2d.global_position - global_position
	bullet.global_position = marker_2d.global_position 
	get_tree().get_root().add_child(bullet)

