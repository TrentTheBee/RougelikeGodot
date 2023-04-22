extends Node2D

var isAttacking = false #is attacking checks if player is attacking so that other animations dont collide
@export var health = 1000 #basic health variable
@export var speed = 200 #this is kinda the max speed the player can get too
@export var acceleration = 10 #how fast the player speeds up
var current_speed = 100 #this is the speed the player starts with

@onready 
var sword = $sword # get a reference to the Area2D node sword

func _on_sword_body_entered(body):
	if body.is_in_group("Enemy"): # check if the body that entered is an enemy
		body.health -= 10 # reduce the enemy's health by 10
		if body.health <= 0: # check if the enemy's health is 0 or less
			body.dead = true # set the enemy's dead variable to true

#movement script
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right") and isAttacking == false: #move right play run animation and look toward the right
		velocity.x += 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("left") and isAttacking == false: #move left play run animation and look toward the left
		velocity.x -= 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
		
	if Input.is_action_pressed("down") and isAttacking == false: #move down and play run animation
		velocity.y += 1
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("up") and isAttacking == false: #move up and play run animation
		velocity.y -= 1
		$AnimatedSprite2D.play("run")
		
	#makes it so as the player moves more the player moves faster
	if velocity.length() > 0:
		current_speed = min(current_speed + acceleration * delta, speed)
	elif isAttacking == false:
		$AnimatedSprite2D.play("idle")
		current_speed = max(current_speed - acceleration * delta, 100)
	
	velocity = velocity.normalized() * current_speed
	position += velocity * delta
	
	#enemy script
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
		print("hit")
		await get_tree().create_timer(0.001).timeout # waits for 1 second
		body.state = body.surround 

func _on_area_2d_2_body_exited(body):
	if body.is_in_group("Enemy"):
		body.state = body.surround

