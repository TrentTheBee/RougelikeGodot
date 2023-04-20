extends Node2D

@export var speed = 1000
@export var acceleration = 10
var current_speed = 100

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	if velocity.length() > 0:
		current_speed = min(current_speed + acceleration * delta, speed)
	else:
		current_speed = max(current_speed - acceleration * delta, 0)
	velocity = velocity.normalized() * current_speed
	position += velocity * delta
	
