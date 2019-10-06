extends Node2D

const BulletClass = preload("res://Bullet.tscn")
const COOLDOWN = 1

var can_shoot = true

func _ready():
	$Timer.set_wait_time(COOLDOWN)

func shoot():
	if not can_shoot:
		return
	var bullet = BulletClass.instance()
	bullet.set_position($BulletSpawner.position)
	bullet.set_dir(Vector2(1, 0).rotated(rotation))
	add_child(bullet)
	can_shoot = false
	$Timer.start()


func _on_Timer_timeout():
	can_shoot = true
