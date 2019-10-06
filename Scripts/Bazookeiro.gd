extends KinematicBody2D

var BulletClass = preload("res://Missil.tscn")

const COOLDOWN = 3

func _ready():
	$Timer.set_wait_time(COOLDOWN)

func shoot():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(1, 0).normalized())
	add_child(bullet)

func _on_Timer_timeout():
	shoot()

func take_damage():
	queue_free()