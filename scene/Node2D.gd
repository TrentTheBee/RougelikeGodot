extends Node2D

var score = 0

@onready var marker_2d = $"Pixilart-drawing(1)/Marker2D"

var fire_type = 1

@onready var marker_2d_2 = $"Pixilart-drawing(1)/Marker2D2"

@onready var marker_2d_3 = $"Pixilart-drawing(1)/Marker2D3"

var bullet_scene = preload("res://scene/bullet.tscn")



func _physics_process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("projectile"):
		fire()

func _process(delta):
	if score >= 30:
		fire_type = 2

func fire():
	if fire_type == 1:
		var bullet = bullet_scene.instantiate()
		print(bullet.direction)
		bullet.direction = marker_2d.global_position - global_position
		bullet.global_position = marker_2d.global_position 
		get_tree().get_root().add_child(bullet)
		
	if fire_type == 2:
		var bullet = bullet_scene.instantiate()
		print(bullet.direction)
		bullet.direction = marker_2d.global_position - global_position
		bullet.global_position = marker_2d.global_position 
		get_tree().get_root().add_child(bullet)
		
		var bullet2 = bullet_scene.instantiate()
		print(bullet2.direction)
		bullet2.direction = marker_2d_2.global_position - global_position
		bullet2.global_position = marker_2d_2.global_position 
		get_tree().get_root().add_child(bullet2)
		
		var bullet3 = bullet_scene.instantiate()
		print(bullet3.direction)
		bullet3.direction = marker_2d_3.global_position - global_position
		bullet3.global_position = marker_2d_3.global_position 
		get_tree().get_root().add_child(bullet3)


func _on_score_timer_timeout():
	score += 1
