extends KinematicBody2D

var BulletClass = preload("res://Bullet.tscn")

const COOLDOWN = 1.5

func shoot():
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(-1, 0))
	add_child(bullet)

func _on_Timer_timeout():
	shoot()

func take_damage():
	queue_free()