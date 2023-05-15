extends CharacterBody2D

@onready 
var cpu_particles_2d = $CPUParticles2D

var death_animation_playing = false
var dead = false
var isAttacking = false #is attacking checks if player is attacking so that other animations dont collide
var knockback_velocity = Vector2.ZERO
@export var health = 1000 #basic health variable
@export var speed = 200 #this is kinda the max speed the player can get too
@export var acceleration = 10 #how fast the player speeds up
var current_speed = 100 #this is the speed the player starts with

@onready 
var sword = $sword # get a reference to the Area2D node sword

func _on_sword_body_entered(body):
	if body.is_in_group("Enemy") and dead == false: # check if the body that entered is an enemy
		body.health -= 50# reduce the enemy's health by 50
		body.cpu_particles_2d.emitting = true 
		if body.health <= 0: # check if the enemy's health is 0 or less
			body.cpu_particles_2d.emitting = true
			body.dead = true # set the enemy's dead variable to true
		else:
			var knockback_direction = (body.global_transform.origin - global_transform.origin).normalized()
		var knockback_direction = (body.global_transform.origin - global_transform.origin).normalized()
		
		await get_tree().create_timer(0.2).timeout
		
		body.velocity += knockback_direction * 400
			

#movement script
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("right") and isAttacking == false and dead == false: #move right play run animation and look toward the right
		velocity.x += 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
		$sword/CollisionShape2D.position.x = abs($sword/CollisionShape2D.position.x)
		
		
	if Input.is_action_pressed("left") and isAttacking == false and dead == false: #move left play run animation and look toward the left
		velocity.x -= 1
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
		$sword/CollisionShape2D.position.x = -abs($sword/CollisionShape2D.position.x)
		
	if Input.is_action_pressed("down") and isAttacking == false and dead == false: #move down and play run animation
		velocity.y += 1
		$AnimatedSprite2D.play("run")
		
	if Input.is_action_pressed("up") and isAttacking == false and dead == false: #move up and play run animation
		velocity.y -= 1
		$AnimatedSprite2D.play("run")

	#makes it so as the player moves more the player moves faster
	if velocity.length() > 0 and dead == false:
		current_speed = min(current_speed + acceleration * delta, speed)
	elif isAttacking == false and dead == false:
		$AnimatedSprite2D.play("idle")
		current_speed = max(current_speed - acceleration * delta, 100)
	
	velocity = velocity.normalized() * current_speed
	position += velocity * delta
	
	#attack script
	if Input.is_action_just_pressed("attack") and dead == false:
		$AnimatedSprite2D.play("attack")
		$sword/CollisionShape2D.disabled = false
		isAttacking = true
		
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		isAttacking = false
		$sword/CollisionShape2D.disabled = true
		
	#enemy script
func _on_area_2d_body_entered(body):
	if body.is_in_group("Enemy") and dead == false:
		body.attack_timer.start()

func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemy")and dead == false:
		body.attack_timer.stop()
		body.state = body.surround


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Enemy")and dead == false:
		body.state = body.hit
		await get_tree().create_timer(0.01).timeout
		body.state = body.surround

func _on_area_2d_2_body_exited(body):
	if body.is_in_group("Enemy")and dead == false:
		body.state = body.surround

func _physics_process(delta):
	if knockback_velocity.length() > 0 and dead == false:
		move_and_slide()
		knockback_velocity = knockback_velocity.linear_interpolate(Vector2.ZERO, 0.1)
	move_and_collide(velocity)
	
	if health <= 0 and not death_animation_playing: 
		dead = true
		$CollisionShape2D.disabled = true
		$Area2D/attract.disabled = true
		$Area2D2/attack.disabled = true
		print("dead")
		$AnimatedSprite2D.play("death")
		death_animation_playing = true
		await get_tree().create_timer(2).timeout
		$GameOverSound.play()
		get_tree().change_scene_to_file("res://scene/Game_Over.tscn")

		
	if Input.is_action_just_pressed("projectile"):
		fire()

var bullet_scene = preload("res://scene/bullet.tscn")

func fire():
	var bullet = bullet_scene.instantiate()
	bullet.direction = $Marker2D.global_position - global_position
	bullet.global_position = $Marker2D.global_position
	get_tree().get_root().add_child(bullet)

