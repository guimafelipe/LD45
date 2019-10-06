extends Area2D

const SPEED = 700
var velocity = Vector2()
var origin_is_player = false

func set_dir(dir):
	velocity = dir*SPEED

func _physics_process(delta):
	translate(velocity*delta)

func set_origin_is_player():
	origin_is_player = true

func _on_Bullet_body_entered(body):
	if body.has_method("hit"):
		body.hit()
	queue_free()


func _on_Bullet_area_entered(area):
	if area.name == "Bullet" or area.name == "Missil":
		queue_free()
