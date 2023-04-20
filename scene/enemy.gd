extends CharacterBody2D

@export var speed = 100
var randomNum 

var target
enum {surround, attack, hit}

var state = surround

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomNum = rng.randf()

@onready
var player = get_node("/root/Main/Player")

func _physics_process(delta):
	match state:
		surround:
			move(get_circle_position(randomNum), delta,)

func move(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()

func get_circle_position(random):
	var kill_circle_centre = player.global_position
	var radius = 40
	var angle = random * PI * 2
	var x = kill_circle_centre.x + cos(angle) * radius 
	var y = kill_circle_centre.y + sin(angle) * radius 
	
	return Vector2(x, y)
