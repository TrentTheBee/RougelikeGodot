extends Area2D

var direction = Vector2.RIGHT
var speed = 400

func _process(delta):
	translate(direction.normalized() * speed * delta)
	
