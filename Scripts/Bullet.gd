extends KinematicBody2D

const SPEED = 700
var velocity = Vector2()
var origin_is_player = false

func set_dir(dir):
	velocity = dir*SPEED

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		queue_free()

func set_origin_is_player():
	origin_is_player = true