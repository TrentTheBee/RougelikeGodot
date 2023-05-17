extends Area2D
var speed = 400
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

func _ready():
	velocity = direction.normalized() * speed
	set_physics_process(true)

func _process(delta):
	translate(velocity * delta)
	look_at(get_global_mouse_position())
func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= 35
		body.cpu_particles_2d.emitting = true
		if body.health <= 0:
			body.dead = true
	queue_free()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
