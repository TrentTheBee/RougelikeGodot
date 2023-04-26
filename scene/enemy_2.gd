extends CharacterBody2D

var dead = false
@export var damage = 300 #the damage dealt by the enemy
@export var health = 100 #the enemys health
@export var speed = 150 #the enemys speed (note unlike player enemys stay at the same speed)
var randomNum #random number see below for random number genrator

@onready var attack_timer = $AttackTimer #this is the attack timer node outside the script

var target #see below for more target variable
enum {surround, attack, hit} #state creation, state, surround, attack, and hit as referenced below

var state = surround 

func _ready(): #gets random number as game starts, this is used for realistic surrounding involving angles
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomNum = rng.randf()
	target = get_circle_position(randomNum)

@onready #@onready code solves an error
var player = get_node("/root/Main/Player") #finding player node in root main

func _physics_process(delta):
	if dead:
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.disabled = true
		$Body/CollisionShape2D.disabled = true
		return
	match state:
		surround: #make an invisible circle around the player and wait before attacking
			move(get_circle_position(randomNum), delta,)
			$AnimatedSprite2D.play("run")
		attack: #move closer into attack
			move(player.global_position, delta)
			$AnimatedSprite2D.play("run")
		hit: #move straight into player, and print hit in the debug console
			move(player.global_position, delta)
			$AnimatedSprite2D.play("run")
			print("hit")
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

func move(target, delta): #the basics, direction to get the direction its moving, and steering to create more realistic turns.
		var direction = (target - global_position).normalized()
		var desired_velocity = direction * speed
		var steering = (desired_velocity - velocity) * delta * 2.5
		velocity += steering
		move_and_slide()

func get_circle_position(random): #circle stuff 
	var kill_circle_centre = player.global_position
	var radius = 20
	var angle = random * PI * 2
	var x = kill_circle_centre.x + cos(angle) * radius 
	var y = kill_circle_centre.y + sin(angle) * radius 
	
	return Vector2(x, y)

func _on_attack_timer_timeout(): #when the attack timer ends then attack the player
	state = attack

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		$AnimatedSprite2D.stop()
		queue_free()
			
