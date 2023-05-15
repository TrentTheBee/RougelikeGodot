extends Area2D

var direction = Vector2.RIGHT
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)
	


func _on_body_entered(body):
	# do damage here
	#example: body.take_damage(50)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free
