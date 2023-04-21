extends Node2D

@export var health = 1000
@export var speed = 400
@export var acceleration = 10
var current_speed = 100

#movement script
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("run")
		
	if velocity.length() > 0:
		current_speed = min(current_speed + acceleration * delta, speed)
	else:
		$AnimatedSprite2D.play("idle")
		current_speed = max(current_speed - acceleration * delta, 100)
	velocity = velocity.normalized() * current_speed
	position += velocity * delta

#script that allow the enemy to attack the player
func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.attack_timer.start()

func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemy"):
		body.attack_timer.stop()
		body.state = body.surround

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Enemy"):
		body.state = body.hit
		await get_tree().create_timer(0.01).timeout # waits for 1 second
		body.state = body.surround 
